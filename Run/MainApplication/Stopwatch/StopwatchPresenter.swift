//
//  StopwatchPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - StopwatchViewToPresenterProtocol (View -> Presenter)
protocol StopwatchViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
}

// MARK: Protocol - StopwatchInteractorToPresenterProtocol (Interactor -> Presenter)
protocol StopwatchInteractorToPresenterProtocol: AnyObject {

}

class StopwatchPresenter {

    // MARK: Properties
    var router: StopwatchPresenterToRouterProtocol!
    var interactor: StopwatchPresenterToInteractorProtocol!
    weak var view: StopwatchPresenterToViewProtocol!
}

// MARK: Extension - StopwatchViewToPresenterProtocol
extension StopwatchPresenter: StopwatchViewToPresenterProtocol {
    func viewDidLoad() {
    
    }
}

// MARK: Extension - StopwatchInteractorToPresenterProtocol
extension StopwatchPresenter: StopwatchInteractorToPresenterProtocol {
    
}