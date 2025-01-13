public struct Price<C: ICurrency> {
    public let value: Double
    public let currency: C

    public init(
        value: Double,
        currency: C
    ) {
        self.value = value
        self.currency = currency
    }
}

public extension Price {
    var formattedValue: String {
        String(format: "%.02f", value)
    }

    var priceRuWithCurrencyRoundedUp: String {
        value.rounded(.up).asIntRounded.asRuPrice + " " + currency.symbol
    }

    var priceWithCurrencyRoundedUp: String {
        value.rounded(.up).asIntRounded.asPrice + " " + currency.symbol
    }
}

public protocol ICurrency {
    var symbol: String { get }
    var ticker: String { get }
}

public enum Currency: ICurrency {
    case rub

    public var symbol: String {
        switch self {
        case .rub: return "₽"
        }
    }

    public var ticker: String {
        switch self {
        case .rub: return "RUB"
        }
    }
}

extension Price: Equatable where C == Currency {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.currency == rhs.currency
        && lhs.value == rhs.value
    }
}


#if canImport(Darwin)
import Darwin
#elseif os(Linux)
import Glibc
#elseif os(Windows)
import ucrt
#else
#error("Unsupported platform")
#endif

fileprivate extension Double {
	/// Rounds the double to the nearest integer and converts it to an Int.
	/// - Note: Rounding follows the "round half to even" rule, also known as banker's rounding.
	///   This means that if the double is exactly halfway between two integers, it will round
	///   to the nearest even number. For example, 2.5 rounds to 2, and 3.5 rounds to 4.
	var asIntRounded: Int {
		Int(lround(self))
	}
}
