//
//  LoginConfigurator.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import UIKit

class LoginConfigurator {
    func configure() -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let interactor = LoginInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}