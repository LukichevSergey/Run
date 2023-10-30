//
//  DetailTrainingInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation

// MARK: Protocol - DetailTrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol DetailTrainingPresenterToInteractorProtocol: AnyObject {
    
}

class DetailTrainingInteractor {

    // MARK: Properties
    weak var presenter: DetailTrainingInteractorToPresenterProtocol!

}

// MARK: Extension - DetailTrainingPresenterToInteractorProtocol
extension DetailTrainingInteractor: DetailTrainingPresenterToInteractorProtocol {
    
}
