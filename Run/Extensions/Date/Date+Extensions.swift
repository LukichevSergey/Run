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
}
