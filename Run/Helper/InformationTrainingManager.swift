//
//  InformationTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 17.12.2023.
//

import OrderedCollections
import UIKit

final class InformationTrainingManager {
    /// Метод использует массив всех тренировок и подгоняет его под модель для использования в детальном экране
    /// - Parameter data: Массив всех записанных тренировок с моделью Training
    /// - Returns: Возвращает модель тренировок для использования в детальном экране тренировок
    func getTrainingForDetailed(data: OrderedSet<Training>) -> OrderedSet<TrainingCellViewModel> {
        logger.log("\(#fileID) -> \(#function)")
        var trainingModelArray = [TrainingCellViewModel]()
        data.forEach { training in
            trainingModelArray.append(TrainingCellViewModel(identifier: training.id,
                killometrs: "\(String(format: "%.2f", training.distance)) км",
                image: ListImages.Training.circleIcon ?? UIImage(),
                data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                title: Tx.Training.run,
                dateStartStop: "\(training.startTime.formatDate("HH:mm")) - \(training.finishTime.formatDate("HH:mm"))",
                city: CityCoordinates(latitude: training.coordinatesCity.latitude,
                                                  longitude: training.coordinatesCity.longitude),
                averageTemp: training.averageTemp.toMinutesAndSeconds(),
                allTime: training.time.toMinutesAndSeconds(),
                everyKilometrs: training.everyTimeKilometrs))
        }
        let sortedTraining = trainingModelArray.sorted { $0.data > $1.data }
        return OrderedSet(sortedTraining)
    }
    /// Метод используется для отображения всех тренировок на общем экране тренировок
    /// - Parameter data: Массив всех записанных тренировок с моделью Training
    /// - Returns: Возвращает модель тренировок для использования в общем экране
    func getinformationAllTraining(data: OrderedSet<Training>) -> OrderedSet<TrainingCellViewModel> {
        logger.log("\(#fileID) -> \(#function)")
        let trainingCellViewModels = data.map { training in
            return TrainingCellViewModel(identifier: training.id,
                                         killometrs: "\(String(format: "%.2f", training.distance)) км",
                                         image: ListImages.Training.circleIcon ?? UIImage(),
                                         data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                                         title: Tx.Training.run,
                                         dateStartStop: training.startTime.formatDate("MM"),
                                         city: CityCoordinates(latitude: training.coordinatesCity.latitude,
                                                               longitude: training.coordinatesCity.longitude),
                                         averageTemp: training.averageTemp.toMinutesAndSeconds(),
                                         allTime: training.time.toMinutesAndSeconds(),
                                         everyKilometrs: training.everyTimeKilometrs)
        }
        let sortedTraining = trainingCellViewModels.sorted { $0.data > $1.data }
        return OrderedSet(sortedTraining)
    }
}
