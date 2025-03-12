import Combine
import Foundation

public class CombineAsyncThrowingStream<Upstream: Publisher>: AsyncSequence where Upstream.Output: Sendable {
    public typealias Element = Upstream.Output
    public typealias AsyncIterator = CombineAsyncThrowingStream<Upstream>
    private let stream: AsyncThrowingStream<Upstream.Output, Error>
    private lazy var iterator = stream.makeAsyncIterator()
    private var cancellable: AnyCancellable?

    public init(_ upstream: Upstream) {
        var subscription: AnyCancellable? = nil

        stream = AsyncThrowingStream { continuation in
            subscription = upstream
                .handleEvents(
                    receiveCancel: { continuation.finish(throwing: nil) }
                )
                .sink(
                    receiveCompletion: {
                        switch $0 {
                        case .failure(let error):continuation.finish(throwing: error)
                        case .finished: continuation.finish(throwing: nil)
                        }
                    },
                    receiveValue: { continuation.yield($0) }
                )
        }

        cancellable = subscription
    }


    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
}

extension CombineAsyncThrowingStream: AsyncIteratorProtocol {
    public func next() async throws -> Upstream.Output? {
        try await iterator.next()
    }

    public func makeAsyncIterator() -> Self { self }
}

public extension Publisher where Output: Sendable {
    func asyncThrowingStream() -> CombineAsyncThrowingStream<Self> {
        CombineAsyncThrowingStream(self)
    }
}