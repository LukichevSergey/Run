//
//  DetailedTrainingInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

// MARK: Protocol - DetailedTrainingPresenterToInteractorProtocol (Presenter -> Interactor)
protocol DetailedTrainingPresenterToInteractorProtocol: AnyObject {
}

final class DetailedTrainingInteractor {
    
    // MARK: Properties
    weak var presenter: DetailedTrainingInteractorToPresenterProtocol!
}

// MARK: Extension - DetailedTrainingPresenterToInteractorProtocol
extension DetailedTrainingInteractor: DetailedTrainingPresenterToInteractorProtocol {
}
