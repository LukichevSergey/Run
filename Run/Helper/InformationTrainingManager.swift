//
//  InformationTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 17.12.2023.
//

import OrderedCollections
import UIKit

class InformationTrainingManager {
    func getTrainingForDetailed(data: OrderedSet<Training>) -> OrderedSet<TrainingCellViewModel> { // это модельь нужна для детальной информации
        logger.log("\(#fileID) -> \(#function)")
        var trainingModelArray = [TrainingCellViewModel]()
        var alltime: Double = 0
        data.forEach { training in
            alltime += training.time
            trainingModelArray.append(TrainingCellViewModel(identifier: training.id,
                                                            killometrs: "\(String(format: "%.2f", training.distance)) км",
                                                            image: ListImages.Training.circleIcon ?? UIImage(),
                                                            data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                                                            title: Tx.Training.run,
                                                            dateStartStop: "\(training.startTime.formatDate("HH:mm")) - \(training.finishTime.formatDate("HH:mm"))",
                                                            city: CityCoordinates(latitude: training.coordinatesCity.latitude, longitude: training.coordinatesCity.longitude),
                                                            averageTemp: training.averageTemp.toMinutesAndSeconds(),
                                                            allTime: training.time.toMinutesAndSeconds(),
                                                            everyKilometrs: training.everyTimeKilometrs))
        }
        let sortedTraining = trainingModelArray.sorted { $0.data > $1.data }
        
        return OrderedSet(sortedTraining)
    }
    
    func getinformationAllTraining(data: OrderedSet<Training>) -> OrderedSet<TrainingCellViewModel> { // это можель для отображения текущего  экрана
        logger.log("\(#fileID) -> \(#function)")
        let trainingCellViewModels = data.map { training in
            
            return TrainingCellViewModel(identifier: training.id,
                                         killometrs: "\(String(format: "%.2f", training.distance)) км",
                                         image: ListImages.Training.circleIcon ?? UIImage(),
                                         data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                                         title: Tx.Training.run,
                                         dateStartStop: training.startTime.formatDate("MM"),
                                         city: CityCoordinates(latitude: training.coordinatesCity.latitude, longitude: training.coordinatesCity.longitude),
                                         averageTemp: training.averageTemp.toMinutesAndSeconds(),
                                         allTime: training.time.toMinutesAndSeconds(),
                                         everyKilometrs: training.everyTimeKilometrs)
        }
        let sortedTraining = trainingCellViewModels.sorted { $0.data > $1.data }
        
        return OrderedSet(sortedTraining)
    }
}
