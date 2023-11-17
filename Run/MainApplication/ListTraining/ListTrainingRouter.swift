//
//  ListTrainingRouter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

// MARK: Protocol - ListTrainingPresenterToRouterProtocol (Presenter -> Router)
protocol ListTrainingPresenterToRouterProtocol: AnyObject {

}

final class ListTrainingRouter {

    // MARK: Properties
    weak var view: ListTrainingRouterToViewProtocol!
}

// MARK: Extension - ListTrainingPresenterToRouterProtocol
extension ListTrainingRouter: ListTrainingPresenterToRouterProtocol {

}
