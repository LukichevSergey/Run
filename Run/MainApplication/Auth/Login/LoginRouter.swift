//
//  LoginRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - LoginPresenterToRouterProtocol (Presenter -> Router)
protocol LoginPresenterToRouterProtocol: AnyObject {
    func navigateToMainPage()
}

final class LoginRouter {

    // MARK: Properties
    weak var view: LoginRouterToViewProtocol!
}

// MARK: Extension - LoginPresenterToRouterProtocol
extension LoginRouter: LoginPresenterToRouterProtocol {
    func navigateToMainPage() {
        let mainApplication = RootMainApplicitionController()
        mainApplication.modalPresentationStyle = .fullScreen
        view.presentView(view: mainApplication)
    }
}
