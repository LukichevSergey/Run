//
//  String+Format.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import Foundation

extension String {
    var trimm: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
