//
//  Date+Extensions.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import Foundation

extension Date {
    func formatData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
}

extension Date {
    func formatMonthData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
    
}
    extension Date {
        func formatMonthAndYearData() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            let formattedDateString = dateFormatter.string(from: self)
            return formattedDateString
        }
}
