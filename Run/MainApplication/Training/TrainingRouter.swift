//
//  TrainingRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import Foundation

// MARK: Protocol - TrainingPresenterToRouterProtocol (Presenter -> Router)
protocol TrainingPresenterToRouterProtocol: AnyObject {
    func navigateToDetailViewController()
}

class TrainingRouter {

    // MARK: Properties
    weak var view: TrainingRouterToViewProtocol!
}

// MARK: Extension - TrainingPresenterToRouterProtocol
extension TrainingRouter: TrainingPresenterToRouterProtocol {
    func navigateToDetailViewController() {
        let detailTrainingViewController = DetailTrainingConfigurator().configure()
        view.pushView(view: detailTrainingViewController)
    }
    
    
}
