import Foundation

public extension String {
    func groupsWithSubgroups(for regexPattern: String) -> [[String]] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text,
                range: NSRange(text.startIndex..., in: text))
            return matches
                .compactMap { match in
                    (0..<match.numberOfRanges)
                        .map {
                            let rangeBounds = match.range(at: $0)
                            guard let range = Range(rangeBounds, in: text) else {
                                return ""
                            }
                            return String(text[range])
                        }
                }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    func groups(for regexPattern: String) -> [String] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text,
                range: NSRange(text.startIndex..., in: text))
            return matches
                .compactMap { match in
                    (0..<match.numberOfRanges)
                        .map {
                            let rangeBounds = match.range(at: $0)
                            guard let range = Range(rangeBounds, in: text) else {
                                return ""
                            }
                            return String(text[range])
                        }
                        .first
                }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}