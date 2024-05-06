import Foundation

public struct PostalAddress: Codable, Equatable, Hashable {
    public let city: String?
    public let country: String?
    public let isoCountryCode: String?
    public let postalCode: String?
    public let state: String?
    public let street: String?
    public let subAdministrativeArea: String?
    public let subLocality: String?

    public init(
            city: String?,
            country: String?,
            isoCountryCode: String?,
            postalCode: String?,
            state: String?,
            street: String?,
            subAdministrativeArea: String?,
            subLocality: String?
    ) {
        self.city = city
        self.country = country
        self.isoCountryCode = isoCountryCode
        self.postalCode = postalCode
        self.state = state
        self.street = street
        self.subAdministrativeArea = subAdministrativeArea
        self.subLocality = subLocality
    }
}