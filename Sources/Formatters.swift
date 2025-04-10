import Foundation

// A set of cached predefined formatters for convenient and efficient use from SwiftUI
public extension DateFormatter {
    static let mediumDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let shortDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let longDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let fullDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
}

public extension PersonNameComponentsFormatter {
    static let mediumNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .medium
        return formatter
    }()
    
    static let shortNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .short
        return formatter
    }()
    
    static let longNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .long
        return formatter
    }()
    
    static let abbreviatedNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .abbreviated
        return formatter
    }()
}
