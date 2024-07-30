import Foundation


public extension String {
	var removingWhitespaces: String {
		components(separatedBy: .whitespaces).joined()
	}
	func replacingWhitespaces(with character: Character) -> Self {
		components(separatedBy: .whitespaces).joined(separator: String(character))
	}
}


public extension String {
	func cleanHtml() -> String {
		self.replacingOccurrences(
			of: "<[^>]+>",
			with: "",
			options: .regularExpression,
			range: nil
		)
	}
	
	func clean(pattern: String) -> String {
		self.replacingOccurrences(
			of: pattern,
			with: "",
			options: .regularExpression,
			range: nil
		)
	}
	
	
	var isWhiteSpaceOrEmpty: Bool {
		self
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.isEmpty
	}
}

public extension String {
	var doubleVal: Double? {
		let clear = self.replacingOccurrences(of: ",", with: ".")
		return Double(clear)
	}
}
