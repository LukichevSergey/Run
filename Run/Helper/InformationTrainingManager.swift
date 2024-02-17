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
        let sortDataTraining = data.sorted { $0.startTime > $1.startTime }
        let trainingModelArray = sortDataTraining.map { training in
            return TrainingCellViewModel(identifier: training.id,
                killometrs: "\(String(format: "%.2f", training.distance)) \(Tx.Timer.kilometr)",
                image: ListImages.Training.circleIcon ?? UIImage(),
                data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                title: Tx.Training.run,
                dateStartStop: "\(training.startTime.formatDate("HH:mm")) - \(training.finishTime.formatDate("HH:mm"))",
                city: CityCoordinates(latitude: training.coordinatesCity.latitude,
                                                  longitude: training.coordinatesCity.longitude),
                averageTemp: training.averageTemp.toMinutesAndSeconds(),
                allTime: training.time.toMinutesAndSeconds(),
                everyKilometrs: training.everyTimeKilometrs)
        }
        return OrderedSet(trainingModelArray)
    }
    /// Метод используется для отображения всех тренировок на общем экране тренировок
    /// - Parameter data: Массив всех записанных тренировок с моделью Training
    /// - Returns: Возвращает модель тренировок для использования в общем экране
    func getinformationAllTraining(data: OrderedSet<Training>) -> OrderedSet<TrainingCellViewModel> {
        logger.log("\(#fileID) -> \(#function)")
        let sortDataTraining = data.sorted { $0.startTime > $1.startTime }
        let trainingCellViewModels = sortDataTraining.map { training in
            return TrainingCellViewModel(identifier: training.id,
                                killometrs: "\(String(format: "%.2f", training.distance)) \(Tx.Timer.kilometr)",
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
        return OrderedSet(trainingCellViewModels)
    }
}
