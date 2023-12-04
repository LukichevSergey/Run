//
//  StopwatchInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//
//

import Foundation
import CoreLocation

// MARK: Protocol - StopwatchPresenterToInteractorProtocol (Presenter -> Interactor)
protocol StopwatchPresenterToInteractorProtocol: AnyObject {
    
    var timer: TimerManager { get }
    
    func startTimer()
    func stopTimer()
    func resetTimer()
    func getTimerData() -> TimerViewModel
    func requestAuthorization()
    func roundResult() -> CircleViewModel
    func saveTraining()
}

final class StopwatchInteractor {
    
    private let dataBase: StopwatchToDatabaseServiceProtocol
    private let timerManager: TimerManager
    private let locationManager: LocationManager
    private let trainingManager: TrainingManager
    private let helperValueTemp = HelperValueTempsModel()
    
    // MARK: Properties
    weak var presenter: StopwatchInteractorToPresenterProtocol!
    
    init() {
        dataBase = DatabaseService()
        timerManager = TimerManager()
        trainingManager = TrainingManager(user: GlobalData.userModel.value ?? AppUser(id: "", name: ""))
        locationManager = LocationManager()
        locationManager.delegate = self
        trainingManager.delegate = self
    }
}

// MARK: Extension - StopwatchPresenterToInteractorProtocol
extension StopwatchInteractor: StopwatchPresenterToInteractorProtocol {
    var timer: TimerManager {
        logger.log("\(#fileID) -> \(#function)")
        return timerManager
    }
    
    func stopTimer() {
        logger.log("\(#fileID) -> \(#function)")
        timerManager.stopTimer()
        locationManager.stopUpdatingLocation()
        trainingManager.setTrainingStatus(on: .pause)
        trainingManager.updateTraining(with: trainingManager.coordinates)
        trainingManager.coordinates = []
    }
    
    func startTimer() {
        logger.log("\(#fileID) -> \(#function)")
        timerManager.startTimer()
        locationManager.startUpdatingLocation()
        trainingManager.createTraining()
        trainingManager.setTrainingStatus(on: .start)
    }
    
    func resetTimer() {
        logger.log("\(#fileID) -> \(#function)")
        locationManager.stopUpdatingLocation()
        trainingManager.setTrainingStatus(on: .stop)
        trainingManager.updateTraining(with: trainingManager.coordinates)
        trainingManager.coordinates = []
        
        let lastDistanceTraining = helperValueTemp.currentDistance
        let lastTempTraining = helperValueTemp.currentTemp
        let lastAverageTraining = helperValueTemp.currentAverageTemp
        let everyTimeKilometrs = helperValueTemp.everyKilometrs
        trainingManager.saveLastDataTrainingChange(average: lastAverageTraining,
                                                   distance: lastDistanceTraining,
                                                   temp: lastTempTraining,
                                                   time: timer.elapsedTime,
                                                   everyKM: everyTimeKilometrs)
        trainingManager.stopTraining()
        timerManager.resetTimer()
        helperValueTemp.resetAll()
    }
    
    func roundResult() -> CircleViewModel {
        logger.log("\(#fileID) -> \(#function)")
        let distance = trainingManager.getDistance()
        let timeCircles = timer.elapsedTime - helperValueTemp.circleTimeAll
        let circleDistance = distance - helperValueTemp.circleDistanceAll
        
        helperValueTemp.saveCircleHelper(circle: 1, circleDistance: circleDistance, circleTime: timeCircles)
                
        return CircleViewModel(circle: "\(Tx.CircleTableResult.circle) \(helperValueTemp.circleCount)",
                               distance: "\(String(format: "%.2f", circleDistance / 1000))",
                               time: "\(timeCircles.toMinutesAndSeconds())")
    }
    
    func getTimerData() -> TimerViewModel {
        logger.log("\(#fileID) -> \(#function)")
        let distance = trainingManager.getDistance()
        let avgerageTemp = trainingManager.getAverageTempModel(distance: distance, time: timer.elapsedTime)
        let tempOneKillomert = trainingManager.getTempModel(distance: distance,
                                                            time: timer.elapsedTime,
                                                            kmTraveled: helperValueTemp.kmTraveled,
                                                            kmIteration: helperValueTemp.kmIteration,
                                                            timeAllKM: helperValueTemp.timeAllKM)
                                
        return TimerViewModel(kilometrModel: .init(data: "\(String(format: "%.2f", distance / 1000))", description: Tx.Timer.kilometr),
                              tempModel: .init(data: "\(tempOneKillomert)", description: Tx.Timer.temp),
                              averageTempModel: .init(data: "\(avgerageTemp)", description: Tx.Timer.averageTemp))
    }
    
    func requestAuthorization() {
        logger.log("\(#fileID) -> \(#function)")
        locationManager.requestAuthorization()
    }
    
    func saveTraining() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                guard let user = GlobalData.userModel.value else { return }
                guard let training = trainingManager.getLastTraining() else { return }
                try await dataBase.saveTraining(training: training)
                try await dataBase.updateSneakers(for: user.getId(), on: training.distance)
            } catch {
                presenter.updateTrainingDataWithError(error)
            }
        }
    }
}

extension StopwatchInteractor: LocationManagerDelegate {
    func didUpdateUserLocation(_ location: CLLocation) {
        logger.log("\(#fileID) -> \(#function)")
        guard trainingManager.trainingStatus == .start else { return }
        trainingManager.coordinates.append(location.coordinate)
        presenter.userLocationIsUpdated()
    }
}

extension StopwatchInteractor: UpdateDataTempDelegate {
    func everyTimeKilometrs(_ everyTimeKM: String) {
        helperValueTemp.saveEveryTimeKilometrs(everyTimeKM)
    }
    
    func currentDistanceChanged(distance: Double) {
        logger.log("\(#fileID) -> \(#function)")
        helperValueTemp.saveCurrentDistance(distance: distance)
    }
    
    func сurrentAverageTempChanged(average: Double) {
        logger.log("\(#fileID) -> \(#function)")
        helperValueTemp.saveCurrentAverageTemp(average: average)
    }
    
    func сurrentTempChanged(temp: Double) {
        logger.log("\(#fileID) -> \(#function)")
        helperValueTemp.saveCurrentTemp(temp: temp)
    }
    
    func currentResultsСhanged(time: Double, traveled: Double, iteration: Int) {
        logger.log("\(#fileID) -> \(#function)")
        helperValueTemp.saveTempHelper(time: time, traveled: traveled, iteration: iteration)
    }
}
