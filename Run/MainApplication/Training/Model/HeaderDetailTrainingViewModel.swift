//
//  HeaderDetailTrainingViewModel.swift
//  Run
//
//  Created by Evgenii Kutasov on 05.11.2023.
//

import Foundation

struct HeaderDetailTrainingViewModel: Hashable {
    let identifier = UUID()
    let month: String
    let countTraining: Int
    let allTime: String
    let averageTime: String
    var training: [TrainingCellViewModel]
    
}