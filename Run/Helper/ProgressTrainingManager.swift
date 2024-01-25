//
//  ProgressTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import OrderedCollections
import CoreMotion

final class ProgressTrainingManager {

    func getStepsAndKmCountForTraining(data: OrderedSet<Training>) -> [String: Float] {
        logger.log("\(#fileID) -> \(#function)")
        let pedometer = CMPedometer()
        var stepCurrentDay = 0
        var metrCurrentDay = 0
        var dictData = [String: Float]()
        let group = DispatchGroup()
                if CMPedometer.isStepCountingAvailable() {
                    group.enter()
                    let calendar = Calendar.current
                    let startDate = calendar.startOfDay(for: Date())
                    let endDate = Date()
                    pedometer.queryPedometerData(from: startDate, to: endDate) { (pedometerData, error) in
                        if let error = error {
                            print("Ошибка при получении данных о шагах: \(error.localizedDescription)")
                            group.leave()
                            return
                        }
                        if let data = pedometerData {
                            let stepsCount = data.numberOfSteps.intValue
                            let metrCount = data.distance?.intValue
                            stepCurrentDay += stepsCount
                            metrCurrentDay += metrCount ?? 0
                        }
                        group.leave()
                    }
                } else {
                    print("Счетчик шагов недоступен на данном устройстве.")
                }
        group.wait()
        dictData["step"] = Float(stepCurrentDay)
        dictData["km"] = Float(metrCurrentDay / 1000)
        return dictData
    }
}
