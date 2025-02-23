import Foundation

@discardableResult
public func measure(_ action: () -> ()) -> TimeInterval {
    let start = Date()
    action()
    let end = Date()
    return end.timeIntervalSince(start)
}

public func measure(_ action: () -> (), onComplete: (TimeInterval) -> ()) {
    let start = Date()
    action()
    let end = Date()
    onComplete(end.timeIntervalSince(start))
}

@discardableResult
public func measure(_ action: () async -> ()) async -> TimeInterval {
    let start = Date()
    await action()
    let end = Date()
    return end.timeIntervalSince(start)
}

public func measure(_ action: () -> (), log: (TimeInterval)->()) {
    let start = Date()
    action()
    let end = Date()
    log(end.timeIntervalSince(start))
}

public func measure(_ action: () async -> (), log: (TimeInterval)->()) async {
    let start = Date()
    await action()
    let end = Date()
    log(end.timeIntervalSince(start))
}
