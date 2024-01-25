//
//  LoginPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - LoginViewToPresenterProtocol (View -> Presenter)
protocol LoginViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func loginButtonTapped()
    func emailIsChanged(to email: String)
    func passwordIsChanged(to password: String)
}

// MARK: Protocol - LoginInteractorToPresenterProtocol (Interactor -> Presenter)
protocol LoginInteractorToPresenterProtocol: AnyObject {
    func userIsSingIn()
    func userIsSignInWithError(error: Error)
}

final class LoginPresenter {

    // MARK: Properties
    var router: LoginPresenterToRouterProtocol!
    var interactor: LoginPresenterToInteractorProtocol!
    weak var view: LoginPresenterToViewProtocol!
}

// MARK: Extension - LoginViewToPresenterProtocol
extension LoginPresenter: LoginViewToPresenterProtocol {
    func emailIsChanged(to email: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setEmail(to: email)
    }
    func passwordIsChanged(to password: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setPassword(to: password)
    }
    func loginButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchLoginData()
    }
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
    }
}

// MARK: Extension - LoginInteractorToPresenterProtocol
extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func userIsSignInWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        view.showErrorAlert(with: error.localizedDescription)
    }
    func userIsSingIn() {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        router.navigateToMainPage()
    }
}
