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
        interactor.setEmail(to: email)
    }
    
    func passwordIsChanged(to password: String) {
        interactor.setPassword(to: password)
    }
    
    func loginButtonTapped() {
        view.showActivityIndicator()
        interactor.fetchLoginData()
    }
    
    func viewDidLoad() {
    
    }
}

// MARK: Extension - LoginInteractorToPresenterProtocol
extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func userIsSignInWithError(error: Error) {
        view.removeActivityIndicator()
        view.showErrorAlert(with: error.localizedDescription)
    }
    
    func userIsSingIn() {
        view.removeActivityIndicator()
        router.navigateToMainPage()
    }
}
