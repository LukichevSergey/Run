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

    func getDetailedTrainingUnprocessed(_ data: TrainingCellViewModel, completion: @escaping ([EnumDetailedViewCell]) -> Void) {
        logger.log("\(#fileID) -> \(#function)")
        var detailedTraining = [EnumDetailedViewCell]()
        
        locationManager.getCityFromCoordinates(data.city[0], data.city[1]) { city in
            detailedTraining.append(.detailedInfo(
                DetailedInfoViewModel(image: ListImages.Training.circleIcon ?? UIImage(),
                                      activityTraining: Tx.Training.run,
                                      target: "\(Tx.Training.target):",
                                      timeStartStop: data.dateStartStop,
                                      city: "г. \(city)")
            ))
            
            detailedTraining.append(.detailedResult(
                DetailedResultViewModel(allTimeTraining: data.allTime,
                                        distance: data.killometrs,
                                        averageTemp: data.averageTemp)
            ))
            
            detailedTraining.append(.detailedEveryKilometer(
                DetailedEveryKilometrViewModel(time: data.everyKilometrs)
            ))
            
            detailedTraining.append(.detailedPulse(
                DetailedPulseViewModel(graphicPulse: "PULSE")
            ))
            
            detailedTraining.append(.detailedMap(
                DetailedMapViewModel(map: "MAP")
            ))
            
            completion(detailedTraining)
        }
    }
    
    func getDateDetailerTrainig(_ data: TrainingCellViewModel) -> String {
        logger.log("\(#fileID) -> \(#function)")
        if !data.data.isEmpty {
            let inputString = data.data
            let components = inputString.components(separatedBy: " ")
            let dateString = components[0]
            let convertInDate = dateString.formatStringinTime()
            let convertWeekDay = convertInDate.formatDate("E, d MMM")
            
            return convertWeekDay
        }
        
        return Tx.Training.dateNotAvailable
    }
}
