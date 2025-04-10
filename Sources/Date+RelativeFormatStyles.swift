import Foundation

@available(iOS 15, macOS 12, *)
public extension Date.RelativeFormatStyle {
    static let named: Date.RelativeFormatStyle = {
        var formatStyle = Date.RelativeFormatStyle()
        formatStyle.presentation = .named
        return formatStyle
    }()
    
    static let numeric: Date.RelativeFormatStyle = {
        var formatStyle = Date.RelativeFormatStyle()
        formatStyle.presentation = .numeric
        return formatStyle
    }()
}
