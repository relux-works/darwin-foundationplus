import Foundation

public extension ClosedRange<Date> {
    var asDaysOfYear: [DayOfYear] {
        var result: [DayOfYear] = []
        var next = self.lowerBound.startOfDay
        while next <= self.upperBound.endOfDay {
            result.append(.init (date: next))
            next = next.add(days: 1)
        }

        return result
    }
}