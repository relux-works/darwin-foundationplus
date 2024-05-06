import Foundation

public extension Decodable {
    static func decode(from data: Data?, logErr: Bool = false) -> Self? {
        guard let data = data else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            if logErr { print("decoding error: \(error)") }
            return nil
        }
    }
}


public extension Decodable {
    init?(fromJsonData: Data?, logErr: Bool = false) {
        if fromJsonData != nil,
            let instance = Self.decode(from: fromJsonData, logErr: logErr) {
            self = instance
        } else {
            return nil
        }
    }
}
