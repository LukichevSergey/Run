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
}

class StopwatchInteractor {
    
    private let timerManager = TimerManager()

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
}
