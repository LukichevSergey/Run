//
//  RegistrationConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import UIKit

final class RegistrationConfigurator {
    func configure() -> UIViewController {
        logger.log("\(#fileID) -> \(#function)")
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
        let interactor = RegistrationInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
