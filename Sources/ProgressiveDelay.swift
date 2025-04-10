import Foundation

public struct ProgressiveDelay {
    public typealias Transformation = @Sendable (TimeInterval) -> TimeInterval
    public typealias Id = String

    public private(set) var id: Id
    public private(set) var currentValue: TimeInterval
    private let initialDelay: TimeInterval
    private let limitation: TimeInterval
    private let incrementTransformer: Transformation

    public init(
        id: String = UUID().uuidString,
        initialDelay: TimeInterval = 0,
        limitation: TimeInterval = .infinity,
        incrementTransformer: @escaping Transformation = exponentialTransformer
    ) {
        self.id = id
        self.currentValue = initialDelay
        self.initialDelay = initialDelay
        self.limitation = limitation
        self.incrementTransformer = incrementTransformer
    }

    @discardableResult
    public mutating func increment() -> Self {
        self.currentValue = self.newDelay
        return self
    }

    public func incremented() -> Self {
        .init(
            id: self.id,
            initialDelay: self.newDelay,
            limitation: self.limitation,
            incrementTransformer: self.incrementTransformer
        )
    }

    @discardableResult
    public mutating func reset() -> Self {
        self.currentValue = self.initialDelay
        return self
    }

    public func reseted() -> Self {
        .init(
            id: self.id,
            initialDelay: self.initialDelay,
            limitation: self.limitation,
            incrementTransformer: self.incrementTransformer
        )
    }

    private var newDelay: TimeInterval {
        min(self.incrementTransformer(self.currentValue), self.limitation)
    }
}

public extension ProgressiveDelay {
    static let exponentialTransformer: Transformation = { delay in
        guard delay > 0 else { return 1 }
        return exp(delay)
    }
}
