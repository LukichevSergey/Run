//
//  TrainingPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import Foundation

// MARK: Protocol - TrainingViewToPresenterProtocol (View -> Presenter)
protocol TrainingViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
}

// MARK: Protocol - TrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol TrainingInteractorToPresenterProtocol: AnyObject {

}

class TrainingPresenter {

    // MARK: Properties
    var router: TrainingPresenterToRouterProtocol!
    var interactor: TrainingPresenterToInteractorProtocol!
    weak var view: TrainingPresenterToViewProtocol!
}

// MARK: Extension - TrainingViewToPresenterProtocol
extension TrainingPresenter: TrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
    }
}

// MARK: Extension - TrainingInteractorToPresenterProtocol
extension TrainingPresenter: TrainingInteractorToPresenterProtocol {
    
}
