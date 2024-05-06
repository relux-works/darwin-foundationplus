import Foundation

public extension URL {
    var asComponents: URLComponents? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}