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
