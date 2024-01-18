//
//  Date+Extensions.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import Foundation

extension Date {
    func formatDate(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let formattedDateString = dateFormatter.string(from: self)
        
        return formattedDateString
    }
    
    func firstOfWeek() -> Date {
        let calendar = Calendar.current
        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) {
            
            return startOfWeek
        } else {
            
            return Date()
        }
    }
    
    func lastOfWeek() -> Date {
        let calendar = Calendar.current
        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)),
           let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) {
            
            return endOfWeek
        } else {
            
            return Date()
        }
    }
    
    func firstDayOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components) ?? Date()
    }
    
    func lastDayOfMonth() -> Date {
        let calendar = Calendar.current
        if let startOfMonth = calendar.dateInterval(of: .month, for: self)?.start {
            
            return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) ?? Date()
        }
        
        return Date()
    }
    
    func firstMonthOfYear() -> Date {
        let calendar = Calendar.current

        return calendar.dateInterval(of: .year, for: self)?.start ?? Date()
    }
    
    func lastMonthOfYear() -> Date {
        let calendar = Calendar.current

        return calendar.dateInterval(of: .year, for: self)?.end ?? Date()
    }
}
