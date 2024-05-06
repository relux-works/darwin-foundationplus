import Foundation

public extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    var isValidPersonalData: Bool {
        let regex = "^(?!\\s)[a-zA-Zа-яА-ЯёЁ\\s'-.]*[a-zA-Zа-яА-ЯёЁ][a-zA-Zа-яА-ЯёЁ\\s'-.]*$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
