import Foundation

import Foundation

public struct DayOfYear: Codable {
    private static let calendar = Calendar(identifier: .gregorian)
    private var components: DateComponents

    public init(date: Date) {
        self.init(
                year: date.get(.year, calendar: Self.calendar),
                month: date.get(.month, calendar: Self.calendar),
                day: date.get(.day, calendar: Self.calendar)
        )
    }

    public init(year: Int, month: Int, day: Int) {
        self.components = .init()
        components.year = year
        components.month = month
        components.day = day
    }

    public var key: String {
        "\(components.year!)-\(components.month!)-\(components.day!)"
    }

    public var date: Date? {
        components.asDate(in: Self.calendar)
    }

    public static func key(from date: Date) -> String {
        let year = date.get(.year, calendar: DayOfYear.calendar)
        let month = date.get(.month, calendar: DayOfYear.calendar)
        let day = date.get(.day, calendar: DayOfYear.calendar)
        return "\(year)-\(month)-\(day)"
    }
}
