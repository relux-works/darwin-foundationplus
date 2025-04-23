import Foundation

public enum DeviceEnv {
    case prod
    case dev

    public static var isSimulator : Bool {
#if targetEnvironment(simulator)
        true
#else
        false
#endif
    }

    public var label: String {
        switch self {
        case .prod: return "PROD"
        case .dev: return "DEV"
        }
    }

    public static var env: DeviceEnv {
        #if DEBUG
            return .dev
        #else
            return .prod
        #endif
    }
}
