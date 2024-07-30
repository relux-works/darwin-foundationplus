import Foundation

public extension UInt {
	/// Converts the unsigned integer (UInt) to a Decimal.
	/// - Returns: A Decimal representation of the unsigned integer.
	var asDecimal: Decimal {
		Decimal(self)
	}
}
