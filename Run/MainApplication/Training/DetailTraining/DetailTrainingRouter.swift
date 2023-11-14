//
//  DetailTrainingRouter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation

// MARK: Protocol - DetailTrainingPresenterToRouterProtocol (Presenter -> Router)
protocol DetailTrainingPresenterToRouterProtocol: AnyObject {

}

final class DetailTrainingRouter {

    // MARK: Properties
    weak var view: DetailTrainingRouterToViewProtocol!
}

// MARK: Extension - DetailTrainingPresenterToRouterProtocol
extension DetailTrainingRouter: DetailTrainingPresenterToRouterProtocol {

}
