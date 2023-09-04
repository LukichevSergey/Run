//
//  RegistrationPresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - RegistrationViewToPresenterProtocol (View -> Presenter)
protocol RegistrationViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func authButtonTapped()
    func usernameIsChanged(to username: String)
    func emailIsChanged(to email: String)
    func passwordIsChanged(to password: String)
}

// MARK: Protocol - RegistrationInteractorToPresenterProtocol (Interactor -> Presenter)
protocol RegistrationInteractorToPresenterProtocol: AnyObject {
    func userIsSingUp()
    func userIsSignUpWithError(error: Error)
}

class RegistrationPresenter {

    // MARK: Properties
    var router: RegistrationPresenterToRouterProtocol!
    var interactor: RegistrationPresenterToInteractorProtocol!
    weak var view: RegistrationPresenterToViewProtocol!
}

// MARK: Extension - RegistrationViewToPresenterProtocol
extension RegistrationPresenter: RegistrationViewToPresenterProtocol {
    func usernameIsChanged(to username: String) {
        interactor.setUsername(to: username)
    }
    
    func emailIsChanged(to email: String) {
        interactor.setEmail(to: email)
    }
    
    func passwordIsChanged(to password: String) {
        interactor.setPassword(to: password)
    }
    
    func authButtonTapped() {
        view.showActivityIndicator()
        interactor.signUp()
    }
    
    func viewDidLoad() {
    
    }
}

// MARK: Extension - RegistrationInteractorToPresenterProtocol
extension RegistrationPresenter: RegistrationInteractorToPresenterProtocol {
    func userIsSignUpWithError(error: Error) {
        view.removeActivityIndicator()
        view.showErrorAlert(with: error.localizedDescription)
    }
    
    func userIsSingUp() {
        view.removeActivityIndicator()
        router.navigateToMainPage()
    }
}
