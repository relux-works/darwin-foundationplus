import Combine

extension Publisher where Output: Sendable, Failure == Never {
    public func sink(receiveValue: @Sendable @escaping (Output) async -> Void) -> AnyCancellable {
        sink { value in
            Task {
                await receiveValue(value)
            }
        }
    }
}

extension Publisher where Output: Sendable {
    public func tryFlatMap<T: Sendable>(_ transform: @Sendable @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                let promiseBox = UncheckedSendableWrapper(payload: promise)
                Task {
                    do {
                        let result = try await transform(value)
                        promiseBox.payload(.success(result))
                    }
                    catch {
                        promiseBox.payload(.failure(error))
                    }
                }
            }
        }
    }
}