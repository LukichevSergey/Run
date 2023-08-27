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

}

class TrainingRouter {

    // MARK: Properties
    weak var view: TrainingRouterToViewProtocol!
}

// MARK: Extension - TrainingPresenterToRouterProtocol
extension TrainingRouter: TrainingPresenterToRouterProtocol {
    
}