//
//  DetailedTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 01.12.2023.
//

import UIKit
import CoreLocation

final class DetailedTrainingManager {
    
    private let locationManager = LocationManager()
    
    func getDetailedTrainigUnprocessed(_ data: TrainingCellViewModel) -> Array<Any> {
        var detailedTrainin = [Any]()
        for elem in 0...4 { // мы знаем что у нас в деталях только 4 ячейки поэтому жестко ставлю такие значения
            if elem == 0 {
                detailedTrainin.append(DetailedInfoViewModel(image: UIImage(named: "circle") ?? UIImage(),
                                                             activityTraining: "Бег",
                                                             target: "Цель:",
                                                             timeStartStop: data.dateStartStop,
                                                             city: "г. \(locationManager.getCityFromCoordinates(data.city[0], data.city[1]))"))
            }
            if elem == 1 {
                detailedTrainin.append(DetailedResultViewModel(allTimeTraining: data.allTime,
                                                               distanse: data.killometrs,
                                                               averageTemp: data.averageTemp))
            }
            if elem == 2 {
                detailedTrainin.append(DetailedEveryKilometrViewModel(time: data.everyKilometrs))
            }
            if elem == 3 {
                detailedTrainin.append(DetailedPulseViewModel(graphicPulse: "PULSE"))
            }
            if elem == 4 {
                detailedTrainin.append(DetailedMapViewModel(map: "MAP"))
            }
        }
        
        return detailedTrainin
    }
    
    func getDateDetailerTrainig(_ data: TrainingCellViewModel) -> String {
        let inputString = data.data
        let components = inputString.components(separatedBy: " ")
        let dateString = components[0]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E, d MMM"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
             return "Неверный формат даты"
        }
    }
}
