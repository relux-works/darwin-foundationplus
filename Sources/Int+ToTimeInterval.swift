public typealias MinsAndHours = (m: UInt, h: UInt)

public extension Double {
    func secondsAsMinutesAndHours(_ roundRule: FloatingPointRoundingRule) -> MinsAndHours {
        (self / 60).rounded(roundRule).asUIntRounded.asMinutesAndHours
    }
	
	/// Rounds the double to the nearest integer and converts it to a UInt.
	/// - Note: Rounding follows the "round half to even" rule, also known as banker's rounding.
	///   This means that if the double is exactly halfway between two integers, it will round
	///   to the nearest even number. For example, 2.5 rounds to 2, and 3.5 rounds to 4.
	///   **Be cautious with negative values, as they will be converted to a UInt after rounding,
	///   which may result in unexpected large values**.
	internal var asUIntRounded: UInt {
		UInt(lround(self))
	}
}

public extension Int {
     enum SecondsToStringPresentation {
         case secondsOnly
         case minutes
         case hours
         case dynamic
     }

     func secondsToString(_ presentation: SecondsToStringPresentation) -> String {
         let hours = self/3600
         let minutes = (self%3600)/60
         let seconds = (self%3600)%60

         switch presentation {
         case .secondsOnly:
             return self.description
         case .minutes:
             return String(format:"%02i:%02i", minutes, seconds)
         case .hours:
             return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
         case .dynamic:
             if hours > 0 {
                 return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
             } else if minutes > 0 {
                 return String(format:"%02i:%02i", minutes, seconds)
             } else {
                 return String(format:"%02i", seconds)
             }
         }
     }
 }

public extension UInt {
    enum SecondsToStringPresentation {
        case secondsOnly
        case minutes
        case hours
        case dynamic
    }

    var asMinutesAndHours: MinsAndHours {
        (
            m: (self%3600)%60,
            h: (self%3600)/60
        )
    }

    func secondsToString(_ presentation: SecondsToStringPresentation) -> String {
        let hours = self/3600
        let minutes = (self%3600)/60
        let seconds = (self%3600)%60

        switch presentation {
        case .secondsOnly:
            return self.description
        case .minutes:
            return String(format:"%02i:%02i", (self/60), seconds)
        case .hours:
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        case .dynamic:
            if hours > 0 {
                return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
            } else if minutes > 0 {
                return String(format:"%02i:%02i", minutes, seconds)
            } else {
                return String(format:"%02i", seconds)
            }
        }
    }
}
