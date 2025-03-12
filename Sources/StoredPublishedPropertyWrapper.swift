import Combine
import Foundation

private nonisolated(unsafe) var subscriptions: Set<AnyCancellable> = []

extension Published where Value: Codable {
    public init(
        wrappedValue defaultValue: Value,
        key: String,
        store: UserDefaults = .standard,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        switch store.data(forKey: key) {
            case .none:
                self.init(initialValue: defaultValue)
            case let .some(data):
                switch try? decoder.decode(Value.self, from: data) {
                    case .none:
                        print("failed to decode: \(String(data: data, encoding: .utf8))")
                        self.init(initialValue: defaultValue)
                    case let .some(val):
                        self.init(initialValue: val)
                }
        }

        projectedValue
            .sink { val in
                switch try? encoder.encode(val) {
                    case .none:
                        print("failed to encode: \(val)")
                    case let .some(data):
                        store.set(data, forKey: key)
                }
            }
            .store(in: &subscriptions)
    }
}
