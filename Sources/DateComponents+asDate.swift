import Foundation

public extension DateComponents {
    var asDate: Date? {
        Calendar.current.date(from: self)
    }

    func asDate(in calendar: Calendar) -> Date? {
        calendar.date(from: self)
    }
}