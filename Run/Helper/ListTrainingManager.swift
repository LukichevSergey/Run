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
        let beginData = Int(data.filter { $0.startTime < Date()}
            .min(by: { $0.startTime < $1.startTime })?.startTime.formatDate("Y") ?? "2023" ) ?? 2023
        var dateTraining = Date()
        for year in beginData...(Int(Date().formatDate("Y")) ?? 0) {
            for month in 1...12 {
                data.forEach { training in
                    if training.startTime.formatDate("M") == "\(month)" &&
                        training.startTime.formatDate("Y") == "\(year)" {
                        countTraining += 1
                        alltime += training.time
                        dateTraining = training.startTime
                        monthTraining.append(TrainingCellViewModel(identifier: training.id,
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
                    trainingModelArray.append(SectionListTrainingModel(
                                month: "\(dateTraining.formatDate("MMM yyyy").capitalized) \(Tx.TimePeriods.year)",
                                countTraining: countTraining,
                                allTime: alltime.toMinutesAndSeconds(),
                                averageTime: (alltime / Double(countTraining)).toMinutesAndSeconds(),
                                training: monthTraining.sorted { $0.data > $1.data }))
                }
                monthTraining.removeAll()
                countTraining = 0
                alltime = 0
            }
        }
        return OrderedSet(trainingModelArray.reversed())
    }
}
