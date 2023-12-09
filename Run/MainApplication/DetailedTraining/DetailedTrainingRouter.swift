//
//  DetailedTrainingRouter.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

// MARK: Protocol - DetailedTrainingPresenterToRouterProtocol (Presenter -> Router)
protocol DetailedTrainingPresenterToRouterProtocol: AnyObject {
}

final class DetailedTrainingRouter {

    // MARK: Properties
    weak var view: DetailedTrainingRouterToViewProtocol!
}

// MARK: Extension - DetailedTrainingPresenterToRouterProtocol
extension DetailedTrainingRouter: DetailedTrainingPresenterToRouterProtocol {
}
