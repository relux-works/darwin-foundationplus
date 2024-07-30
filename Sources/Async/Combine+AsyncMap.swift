import Combine

// awaits until xcode 16 be released
// for now we understand that Combine Map causes warnings in Swift 6 concurrency

//extension AnyPublisher: @unchecked @retroactive Sendable where Output: Sendable, Failure: Sendable {}
//extension Published.Publisher: @unchecked @retroactive Sendable where Value: Sendable, Failure: Sendable {}
//extension Never: Sendable {}
//extension PassthroughSubject: @unchecked @retroactive Sendable where Output: Sendable, Failure: Sendable {}
//extension Publishers.AsyncMap: Sendable where Upstream: Sendable {}

extension Publishers {
	public struct AsyncMap<Upstream: Publisher, Output: Sendable>: Publisher where Upstream.Output: Sendable {
		public typealias Failure = Upstream.Failure

		private let upstream: Upstream
		private let transform: @Sendable (Upstream.Output) async throws -> Output

		init(upstream: Upstream, transform: @escaping @Sendable (Upstream.Output) async throws -> Output) {
			self.upstream = upstream
			self.transform = transform
		}

		public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
			let inner = Inner(downstream: subscriber, transform: transform)
			upstream.subscribe(inner)
		}
	}
}



private extension Publishers.AsyncMap {
	final class Inner<Downstream: Subscriber>: Subscriber, Subscription, @unchecked Sendable
	where Downstream.Input == Output, Downstream.Failure == Failure
	{
		typealias Input = Upstream.Output

		private let downstream: Downstream
		private let transform: @Sendable (Input) async throws -> Output
		private let lock = AsyncLock()
		private var subscription: Subscription?
		private var pending = 0
		private var buffer: [Input] = []
		private var demand: Subscribers.Demand = .none
		private var isCompleted = false
		private var taskCancellation: (() -> Void)?

		init(downstream: Downstream, transform: @escaping @Sendable (Input) async throws -> Output) {
			self.downstream = downstream
			self.transform = transform
		}

		func receive(subscription: Subscription) {
			Task {
				await lock.withLock {
					self.subscription = subscription
					downstream.receive(subscription: self)
				}
			}
		}

		func receive(_ input: Input) -> Subscribers.Demand {
			Task {
				await lock.withLock {
					buffer.append(input)
					processBuffer()
				}
			}
			return .none
		}

		func receive(completion: Subscribers.Completion<Failure>) {
			Task {
				await lock.withLock {
					isCompleted = true
					if pending == 0 {
						downstream.receive(completion: completion)
					}
				}
			}
		}

		func request(_ demand: Subscribers.Demand) {
			Task {
				await lock.withLock {
					self.demand += demand
					processBuffer()
				}
			}
		}

		func cancel() {
			Task {
				await lock.withLock {
					subscription?.cancel()
					subscription = nil
					taskCancellation?()
				}
			}
		}

		private func processBuffer() {
			guard demand > .none else { return }
			while !buffer.isEmpty && demand > .none {
				let input = buffer.removeFirst()
				demand -= 1
				pending += 1

				let task = Task { [weak self] in
					guard let self = self else { return }
					do {
						let output = try await self.transform(input)
						await self.deliverOutput(output)
					} catch {
						await self.deliverCompletion(.failure(error as! Failure))
					}
				}

				taskCancellation = { task.cancel() }
			}

			if buffer.isEmpty {
				subscription?.request(.max(1))
			}
		}

		private func deliverOutput(_ output: Output) async {
			await lock.withLock {
				pending -= 1
				let newDemand = downstream.receive(output)
				demand += newDemand
				processBuffer()
				checkForCompletion()
			}
		}

		private func deliverCompletion(_ completion: Subscribers.Completion<Failure>) async {
			await lock.withLock {
				pending -= 1
				subscription?.cancel()
				subscription = nil
				downstream.receive(completion: completion)
			}
		}

		private func checkForCompletion() {
			if isCompleted && pending == 0 {
				downstream.receive(completion: .finished)
			}
		}
	}
}

extension Publisher where Self: Sendable, Output: Sendable {
	public func asyncMap<T: Sendable>(_ transform: @escaping @Sendable (Output) async throws -> T) -> Publishers.AsyncMap<Self, T> {
		return Publishers.AsyncMap(upstream: self, transform: transform)
	}
}
