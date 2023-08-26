//
//  TrainingInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import Foundation

// MARK: Protocol - TrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol TrainingPresenterToInteractorProtocol: AnyObject {

}

class TrainingInteractor {

    // MARK: Properties
    weak var presenter: TrainingInteractorToPresenterProtocol!

}

// MARK: Extension - TrainingPresenterToInteractorProtocol
extension TrainingInteractor: TrainingPresenterToInteractorProtocol {
    
}