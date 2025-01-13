import Combine

extension Publisher where Self.Failure == Never {
    public func sink(receiveValue: @escaping (Self.Output) async -> Void) -> AnyCancellable {
        sink { value in
            Task {
                await receiveValue(value)
            }
        }
    }
}

extension Publisher {
    public func tryFlatMap<T>(_ transform: @escaping (Self.Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let result = try await transform(value)
                        promise(.success(result))
                    }
                    catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}