//
//  String+Extension.swift
//  Run
//
//  Created by Evgenii Kutasov on 10.12.2023.
//

import Foundation

extension String {
    func formatStringinTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
}
