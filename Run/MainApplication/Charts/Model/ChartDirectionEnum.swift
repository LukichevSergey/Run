//
//  MovermentDirectionEnum.swift
//  Run
//
//  Created by Evgenii Kutasov on 16.01.2024.
//

import Foundation

enum MovementDirection {
    case back
    case forward
    case empty
}

enum IsHiddenButton: String {
    case isHiddenButtonBack
    case isHiddenButtonForward
    case notHiddenButton
}

enum PeriodofTime: Int {
    case week
    case month
    case year
}
