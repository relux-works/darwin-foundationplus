import Foundation

public extension Sequence where Element: AnyDated {
    @inlinable var asDictByDayOfYear: [DayOfYear: Element] {
        self.reduce(into: [DayOfYear: Element]()) { result, next in
            result[DayOfYear.init(date: next.date)] = next
        }
    }
}