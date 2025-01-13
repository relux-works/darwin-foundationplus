import Foundation

extension String {
    public func transliterate() -> String {
        let latinTransform = "Any-Latin; Latin-ASCII; Upper();"
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, latinTransform as CFString, false)
        return mutableString as String
    }
}

