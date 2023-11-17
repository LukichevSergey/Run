//
//  TrainingCellViewModel.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import UIKit

struct TrainingCellViewModel: Hashable {
    let identifier = UUID()
    let killometrs: String
    let image: UIImage
    let data: String
    let title: String
}
