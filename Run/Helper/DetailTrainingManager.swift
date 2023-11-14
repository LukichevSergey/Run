//
//  DetailTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 08.11.2023.
//

import Foundation
import OrderedCollections
import UIKit

final class DetailTrainingManager {
    
    func getDetailTrainingAndHeaderMonth(data: OrderedSet<Training>) -> OrderedSet<HeaderDetailTrainingViewModel> {
        
        var trainingModelArray = [HeaderDetailTrainingViewModel]()
        var monthTraining = [TrainingCellViewModel]()
        var countTraining = 0
        var alltime: Double = 0
        var allAverageTime: Double = 0
        var dateTraining = Date()
        
        for month in 1...12 {
            data.forEach { training in
                if training.startTime.formatMonthData() == "\(month)" {
                    countTraining += 1
                    alltime += training.time
                    dateTraining = training.startTime
                    allAverageTime = training.averageTemp.isNaN ? 0.0 : allAverageTime + training.averageTemp
                    monthTraining.append(TrainingCellViewModel(killometrs: "\(String(format: "%.2f", training.distance)) км",
                                                               image: UIImage(named: "circle") ?? UIImage(),
                                                               data: "\(training.startTime.formatData()) >",
                                                               title: Tx.Training.run))
                }
            }
            
            if !monthTraining.isEmpty {
                trainingModelArray.append(HeaderDetailTrainingViewModel(month: "\(dateTraining.formatMonthAndYearData()) г.",
                                                                        countTraining: countTraining,
                                                                        allTime: alltime.toMinutesAndSeconds(),
                                                                        averageTime: (allAverageTime / Double(countTraining)).toMinutesAndSeconds(),
                                                                        training: monthTraining))
            }

            monthTraining.removeAll()
            countTraining = 0
            alltime = 0
            allAverageTime = 0
        }
        
        return OrderedSet(trainingModelArray.reversed())
    }
}
