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
        
        for month in 1...12 {
            data.forEach { training in
                if training.startTime.formatMonthData() == "\(month)" {
                    countTraining += 1
                    alltime += training.time
                    dateTraining = training.startTime
                    monthTraining.append(TrainingCellViewModel(identifier: training.id,
                                                               killometrs: "\(String(format: "%.2f", training.distance)) км",
                                                               image: ListImages.Training.circleIcon ?? UIImage(),
                                                               data: "\(training.startTime.formatData()) >",
                                                               title: Tx.Training.run,
                                                               dateStartStop: "\(training.startTime.formatTime()) - \(training.finishTime.formatTime())" ,
                                                               city: training.coordinatesCity,
                                                               averageTemp: training.averageTemp.toMinutesAndSeconds(),
                                                               allTime: training.time.toMinutesAndSeconds(),
                                                               everyKilometrs: training.everyTimeKilometrs))
                }
            }
            
            if !monthTraining.isEmpty {
                trainingModelArray.append(SectionListTrainingModel(month: "\(dateTraining.formatMonthAndYearData()) г.",
                                                                        countTraining: countTraining,
                                                                        allTime: alltime.toMinutesAndSeconds(),
                                                                        averageTime: (alltime / Double(countTraining)).toMinutesAndSeconds(),
                                                                        training: monthTraining))
            }

            monthTraining.removeAll()
            countTraining = 0
            alltime = 0
        }
        
        return OrderedSet(trainingModelArray.reversed())
    }
}
