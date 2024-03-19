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
    func firstOfData(_ dateFormatPeriod: PeriodofTime) -> Date {
        let calendar = Calendar.current
        switch dateFormatPeriod {
        case .week:
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                                from: self)) else {
                return Date()
            }
            return startOfWeek
        case .month:
            let components = calendar.dateComponents([.year, .month], from: self)
            return calendar.date(from: components) ?? Date()
        case .year:
            return calendar.dateInterval(of: .year, for: self)?.start ?? Date()
        }
    }
    func lastOfData(_ dateFormatPeriod: PeriodofTime) -> Date {
        let calendar = Calendar.current
        switch dateFormatPeriod {
        case .week:
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                                from: self)),
                  let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
                return Date()
            }
            return endOfWeek
        case .month:
            guard let startOfMonth = calendar.dateInterval(of: .month, for: self)?.start,
                  let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
                return Date()
            }
            return endOfMonth
        case .year:
            return calendar.dateInterval(of: .year, for: self)?.end ?? Date()
        }
    }
}
