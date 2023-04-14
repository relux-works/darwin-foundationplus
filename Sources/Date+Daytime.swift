import Foundation

public enum TimeOfDay: String {
	case morning = "Morning"
	case afternoon = "Afternoon"
	case evening = "Evening"
	case night = "Night"
}

public extension TimeOfDay {
	static var currentTimeOfDay: TimeOfDay {
		Date.now.currentTimeOfDay
	}
}


public extension Date {
	var currentTimeOfDay: TimeOfDay {
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: self)
		
		switch hour {
			case 5..<12:
				return .morning
			case 12..<17:
				return .afternoon
			case 17..<21:
				return .evening
			default:
				return .night
		}
	}
}
