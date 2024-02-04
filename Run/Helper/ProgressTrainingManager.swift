//
//  ProgressTrainingManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import OrderedCollections
import CoreMotion

final class ProgressTrainingManager {

    func getStepsAndKmCountForTraining() -> [String: Float] {
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
                            print("Error when receiving step data: \(error.localizedDescription)")
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
                    print("The step counter is not available on this device.")
                }
        group.wait()
        dictData["step"] = Float(stepCurrentDay)
        dictData["km"] = Float(metrCurrentDay / 1000)
        return dictData
    }
}
