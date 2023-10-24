//
//  ProgressTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 22.10.2023.
//

import Foundation
import OrderedCollections
import CoreMotion

final class ProgressTrainingManager {
    
    func progressKmTraining(data: OrderedSet<Training>) -> Float {
        logger.log("\(#fileID) -> \(#function)")
        var kmAll: Float = 0
        data.forEach { progress in
            if progress.startTime.formatData() == Date().formatData() {
                kmAll += Float(progress.distance)
            }
        }
        
        return kmAll
    }

    func getStepsCountForTraining(data: OrderedSet<Training>) -> Int {
        logger.log("\(#fileID) -> \(#function)")
        let pedometer = CMPedometer()
        var pedometerCurrentDay = 0
        let group = DispatchGroup()
        
        data.forEach { progressPedometr in
            if progressPedometr.startTime.formatData() == Date().formatData() {
                group.enter()
                
                if CMPedometer.isStepCountingAvailable() {
                    let startDate = progressPedometr.startTime
                    let endDate = progressPedometr.finishTime
                    
                    pedometer.queryPedometerData(from: startDate, to: endDate) { (pedometerData, error) in
                        if let error = error {
                            print("Ошибка при получении данных о шагах: \(error.localizedDescription)")
                            group.leave()
                            return
                        }
                        
                        if let data = pedometerData {
                            let stepsCount = data.numberOfSteps.intValue
                            pedometerCurrentDay += stepsCount
                        }
                        
                        group.leave()
                    }
                } else {
                    print("Счетчик шагов недоступен на данном устройстве.")
                    group.leave()
                }
            }
        }
        
        group.wait()
        return pedometerCurrentDay
    }
}
