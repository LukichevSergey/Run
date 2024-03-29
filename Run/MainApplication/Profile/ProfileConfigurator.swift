//
//  ProfileConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit

final class ProfileConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        router.view = view
        return view
    }
}
