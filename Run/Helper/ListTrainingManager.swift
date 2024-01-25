//
//  ListTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 08.11.2023.
//

import OrderedCollections
import UIKit

final class ListTrainingManager {
    func getListTrainingAndHeaderMonth(data: OrderedSet<Training>) -> OrderedSet<SectionListTrainingModel> {
        logger.log("\(#fileID) -> \(#function)")
        var trainingModelArray = [SectionListTrainingModel]()
        var monthTraining = [TrainingCellViewModel]()
        var countTraining = 0
        var alltime: Double = 0
        var dateTraining = Date()
        var identifierMonth = ""
        for month in 1...12 {
            data.forEach { training in
                if training.startTime.formatDate("M") == "\(month)" {
                    countTraining += 1
                    alltime += training.time
                    dateTraining = training.startTime
                    identifierMonth = training.id
                    monthTraining.append(TrainingCellViewModel(identifier: identifierMonth,
                        killometrs: "\(String(format: "%.2f", training.distance)) \(Tx.Timer.kilometr)",
                        image: ListImages.Training.circleIcon ?? UIImage(),
                        data: "\(training.startTime.formatDate("dd.MM.yyyy")) >",
                        title: Tx.Training.run,
                        dateStartStop:
                        "\(training.startTime.formatDate("HH:mm")) - \(training.finishTime.formatDate("HH:mm"))",
                        city: CityCoordinates(latitude: training.coordinatesCity.latitude,
                                              longitude: training.coordinatesCity.longitude),
                        averageTemp: training.averageTemp.toMinutesAndSeconds(),
                        allTime: training.time.toMinutesAndSeconds(),
                        everyKilometrs: training.everyTimeKilometrs))
                }
            }
            if !monthTraining.isEmpty {
                trainingModelArray.append(SectionListTrainingModel(identifier: identifierMonth,
                        month: "\(dateTraining.formatDate("MMM yyyy").capitalized) \(Tx.TimePeriods.year)",
                        countTraining: countTraining,
                        allTime: alltime.toMinutesAndSeconds(),
                        averageTime: (alltime / Double(countTraining)).toMinutesAndSeconds(),
                        training: monthTraining))
            }
            monthTraining.removeAll()
            countTraining = 0
            alltime = 0
            identifierMonth = ""
        }
        return OrderedSet(trainingModelArray)
    }
}
