//
//  HeaderListTrainingViewModel.swift
//  Run
//
//  Created by Evgenii Kutasov on 05.11.2023.
//

import Foundation

struct HeaderListTrainingViewModel: Hashable {
    let identifier = UUID()
    let month: String
    let countTraining: Int
    let allTime: String
    let averageTime: String
    let training: [TrainingCellViewModel] // переиспользуется из обычных тренировок
}
