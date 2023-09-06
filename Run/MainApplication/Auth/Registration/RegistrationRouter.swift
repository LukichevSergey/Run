//
//  RegistrationRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - RegistrationPresenterToRouterProtocol (Presenter -> Router)
protocol RegistrationPresenterToRouterProtocol: AnyObject {
    func navigateToMainPage()
}

final class RegistrationRouter {

    // MARK: Properties
    weak var view: RegistrationRouterToViewProtocol!
}

// MARK: Extension - RegistrationPresenterToRouterProtocol
extension RegistrationRouter: RegistrationPresenterToRouterProtocol {
    func navigateToMainPage() {
        let mainApplication = RootMainApplicitionController()
        mainApplication.modalPresentationStyle = .fullScreen
        view.presentView(view: mainApplication)
    }
}
