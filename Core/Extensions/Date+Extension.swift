import Foundation

// MARK: - Date extension

public extension Date {

    struct Formatter {
        static let customDate: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_br")
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()
    }
    
    func add(value: Int = 0, byAdding: Calendar.Component) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: byAdding, value: value, to: self) ?? Date()
        return targetDay
    }

    func getStringDate() -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let strings = formatter.string(from: today)
        return strings
    }
//
//    func getStringDateWithHour() -> String {
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: self)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM d, yyyy, HH:mm"
//        let strings = formatter.string(from: today)
//        return strings
//    }
    
    func returnBetweenDate(startDate: Date,
                           endDate: Date,
                           years: Bool = false,
                           months: Bool = false,
                           days: Bool = false) -> Int {
        
        let calendar = NSCalendar.current
        
        var components: DateComponents!
        
        if years {
            components = calendar.dateComponents( [.year], from: startDate, to: endDate)
            return components.year ?? 0
        } else if months {
            components = calendar.dateComponents( [.month], from: startDate, to: endDate)
            return components.month ?? 0
        } else{
            components = calendar.dateComponents( [.day], from: startDate, to: endDate)
            return components.day ?? 0
        }
    }
    
    func isSameDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedSame
    }

    func isBeforeDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedAscending
    }

    func isAfterDate(_ comparisonDate: Date) -> Bool {
      let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
      return order == .orderedDescending
    }
}
