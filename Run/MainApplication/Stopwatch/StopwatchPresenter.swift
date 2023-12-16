//
//  StopwatchPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation
import Combine

// MARK: Protocol - StopwatchViewToPresenterProtocol (View -> Presenter)
protocol StopwatchViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func roundButtonTapped(with type: RoundButton.RoundButtonType)
}

// MARK: Protocol - StopwatchInteractorToPresenterProtocol (Interactor -> Presenter)
protocol StopwatchInteractorToPresenterProtocol: AnyObject {
    func userLocationIsUpdated()
    func updateTrainingDataWithError(_ error: Error)
}

final class StopwatchPresenter {

    // MARK: Properties
    var router: StopwatchPresenterToRouterProtocol!
    var interactor: StopwatchPresenterToInteractorProtocol!
    weak var view: StopwatchPresenterToViewProtocol!
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: Extension - StopwatchViewToPresenterProtocol
extension StopwatchPresenter: StopwatchViewToPresenterProtocol {
    
    func roundButtonTapped(with type: RoundButton.RoundButtonType) {
        logger.log("\(#fileID) -> \(#function)")
        switch type {
        case .startButton(let isStarted):
            isStarted ? interactor.startTimer() : interactor.stopTimer()
        case .endButton:
            interactor.resetTimer()
            interactor.saveTraining()
            view.resetStartButton()
            view.setTimer(with: interactor.getTimerData())
        case .roundButton:
            let circleData = interactor.roundResult()
            view.setCircleResult(with: circleData)
            return
        }
    }
    
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        interactor.requestAuthorization()
        view.setTimer(with: interactor.getTimerData())
        interactor.timer.$elapsedTime.sink { [weak self] time in
            self?.view.setTimer(with: time)
        }.store(in: &subscriptions)
    }
}

// MARK: Extension - StopwatchInteractorToPresenterProtocol
extension StopwatchPresenter: StopwatchInteractorToPresenterProtocol {
    func updateTrainingDataWithError(_ error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.showErrorAlert(with: error.localizedDescription)
    }
    
    func userLocationIsUpdated() {
        logger.log("\(#fileID) -> \(#function)")
        view.setTimer(with: interactor.getTimerData())
    }
}
