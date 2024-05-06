extension Date {
    public var month: Month? {
        Month(rawValue: self.get(.month))
    }

    public enum Month: Int {
        case jan = 1
        case feb = 2
        case mar = 3
        case apr = 4
        case may = 5
        case jun = 6
        case jul = 7
        case aug = 8
        case sep = 9
        case oct = 10
        case nov = 11
        case dec = 12
    }
}