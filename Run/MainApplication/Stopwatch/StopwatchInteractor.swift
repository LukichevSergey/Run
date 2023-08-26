//
//  StopwatchInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - StopwatchPresenterToInteractorProtocol (Presenter -> Interactor)
protocol StopwatchPresenterToInteractorProtocol: AnyObject {
    
    var timer: TimerManager { get }
    
    func startTimer()
    func stopTimer()
    func resetTimer()
    func getTimerData() -> [TimerStatsViewModel]
}

class StopwatchInteractor {
    
    private let timerManager = TimerManager()
    
    private let kilometrModel: TimerStatsViewModel = .init(data: "1.72", description: Tx.Timer.kilometr)
    private let tempModel: TimerStatsViewModel = .init(data: "5:30", description: Tx.Timer.temp)
    private let averageTempModel: TimerStatsViewModel = .init(data: "5:45", description: Tx.Timer.averageTemp)

    // MARK: Properties
    weak var presenter: StopwatchInteractorToPresenterProtocol!
}

// MARK: Extension - StopwatchPresenterToInteractorProtocol
extension StopwatchInteractor: StopwatchPresenterToInteractorProtocol {
    var timer: TimerManager {
        return timerManager
    }
    
    func stopTimer() {
        timerManager.stopTimer()
    }
    
    func startTimer() {
        timerManager.startTimer()
    }
    
    func resetTimer() {
        timerManager.resetTimer()
    }
    
    func getTimerData() -> [TimerStatsViewModel] {
        return [kilometrModel, tempModel, averageTempModel]
    }
}
