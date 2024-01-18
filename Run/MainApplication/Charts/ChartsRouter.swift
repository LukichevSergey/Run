//
//  ChartsRouter.swift
//  Run
//
//  Created by Evgenii Kutasov on 02.01.2024.
//

// MARK: Protocol - ChartsPresenterToRouterProtocol (Presenter -> Router)
protocol ChartsPresenterToRouterProtocol: AnyObject {
}

final class ChartsRouter {

    // MARK: Properties
    weak var view: ChartsRouterToViewProtocol!
}

// MARK: Extension - ChartsPresenterToRouterProtocol
extension ChartsRouter: ChartsPresenterToRouterProtocol {
}
