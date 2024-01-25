//
//  ListTrainingConfigurator.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import UIKit

final class ListTrainingConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = ListTrainingViewController()
        let presenter = ListTrainingPresenter()
        let router = ListTrainingRouter()
        let interactor = ListTrainingInteractor()
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        router.view = view
        return view
    }
}
