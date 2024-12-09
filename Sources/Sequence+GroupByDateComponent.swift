import Foundation

public protocol AnyDated {
    var date: Date { get }
}

public extension Sequence where Element: AnyDated {
    func groupBy(_ cadence: Cadence) -> Dictionary<DateComponents, [Element]> {
        Dictionary(grouping: self) { (item: AnyDated) -> DateComponents in
            Calendar.current.dateComponents(cadence.calendarComponents, from: (item.date))
        }
    }
}

public enum Cadence: Sendable {
    case years
    case months
    case weeks
    case days
    case hours
    case minutes

    public var calendarComponents: Set<Calendar.Component> {
        switch self {
        case .years: return [.year]
        case .months: return [.year, .month]
        case .weeks: return [.year, .month, .weekOfMonth]
        case .days: return [.year, .month, .day]
        case .hours: return [.year, .month, .day, .hour]
        case .minutes: return [.year, .month, .day, .hour, .minute]
        }
    }
}

public extension Date {
    func apply(cadence: Cadence, value: Int) -> Date {
        switch cadence {
            case .minutes: return self.add(minutes: value)
            case .hours: return self.add(hours: value)
            case .days: return self.add(days: value)
            case .weeks: return self.add(days: 7 * value)
            case .months: return self.add(months: value)
            case .years: return self.add(years: value)
        }
    }

    mutating func applying(cadence: Cadence, value: Int) {
        self = self.apply(cadence: cadence, value: value)
    }
}
