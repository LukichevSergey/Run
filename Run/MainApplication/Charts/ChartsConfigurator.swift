//
//  ChartsConfigurator.swift
//  Run
//
//  Created by Evgenii Kutasov on 02.01.2024.
//

import UIKit

final class ChartsConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = ChartsViewController()
        let presenter = ChartsPresenter()
        let router = ChartsRouter()
        let interactor = ChartsInteractor()
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        router.view = view
        return view
    }
}
