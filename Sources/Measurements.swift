import Foundation

@discardableResult
public func measure(_ action: () -> ()) -> Double {
    let start = Date()
    action()
    let end = Date()
    return end.timeIntervalSince(start)
}

@discardableResult
public func measure(_ action: () async -> ()) async -> Double {
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