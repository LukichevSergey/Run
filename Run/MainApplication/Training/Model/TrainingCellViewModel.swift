//
//  TrainingCellViewModel.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import UIKit

struct TrainingCellViewModel: Hashable {
    let identifier: String
    let killometrs: String
    let image: UIImage
    let data: String
    let title: String
    let dateStartStop: String
    let city: CityCoordinates
    let averageTemp: String
    let allTime: String
    let everyKilometrs: [String]
}

struct CityCoordinates: Hashable {
    var latitude: Double
    var longitude: Double
}
