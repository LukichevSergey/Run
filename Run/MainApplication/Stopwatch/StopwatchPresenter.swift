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

}

class StopwatchPresenter {

    // MARK: Properties
    var router: StopwatchPresenterToRouterProtocol!
    var interactor: StopwatchPresenterToInteractorProtocol!
    weak var view: StopwatchPresenterToViewProtocol!
    
    private var subscriptions = Set<AnyCancellable>()
}

// MARK: Extension - StopwatchViewToPresenterProtocol
extension StopwatchPresenter: StopwatchViewToPresenterProtocol {
    
    func roundButtonTapped(with type: RoundButton.RoundButtonType) {
        switch type {
        case .startButton(let isStarted):
            isStarted ? interactor.startTimer() : interactor.resetTimer()
        case .endButton, .roundButton:
            return
        }
    }
    
    func viewDidLoad() {
        view.setTimer(with: interactor.getTimerData())
        
        interactor.timer.$elapsedTime.sink { [weak self] time in
            self?.view.setTimer(with: time)
        }.store(in: &subscriptions)
    }
}

// MARK: Extension - StopwatchInteractorToPresenterProtocol
extension StopwatchPresenter: StopwatchInteractorToPresenterProtocol {
    
}
