import Foundation

public struct EmailAddress: Equatable, Codable {
    private let localPart: String
    private let domain: String

    /// - Parameter user: the 'local part' of an email address
    /// - Parameter host: the 'host name' of a FQDN of email address domain
    /// - Parameter tld: the top level domain part of a FQDN of email address domain
    public init(
            user localPart: String,
            host: String,
            tld: String
    ) {
        self.localPart = localPart
        self.domain = "\(host).\(tld)"
    }

    public init?(_ address: String) {
        let parts = address.split(separator: "@")
        if parts.count == 2 {
            self.localPart = String(parts[0])
            self.domain = String(parts[1])
            if isInvalid(address) {
                return nil
            }
        } else {
            return nil
        }
    }

    public var address: String {
        "\(localPart)@\(domain)"
    }
}

public extension EmailAddress {
    private static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    static func isValid(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func isInvalid(_ email: String) -> Bool {
        !isValid(email)
    }

    func isValid(_ email: String) -> Bool {
        Self.isValid(email)
    }

    private func isInvalid(_ email: String) -> Bool {
        !isValid(email)
    }
}