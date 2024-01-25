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

final class RegistrationPresenter {

    // MARK: Properties
    var router: RegistrationPresenterToRouterProtocol!
    var interactor: RegistrationPresenterToInteractorProtocol!
    weak var view: RegistrationPresenterToViewProtocol!
}

// MARK: Extension - RegistrationViewToPresenterProtocol
extension RegistrationPresenter: RegistrationViewToPresenterProtocol {
    func usernameIsChanged(to username: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setUsername(to: username)
    }
    func emailIsChanged(to email: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setEmail(to: email)
    }
    func passwordIsChanged(to password: String) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.setPassword(to: password)
    }
    func authButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.signUp()
    }
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
    }
}

// MARK: Extension - RegistrationInteractorToPresenterProtocol
extension RegistrationPresenter: RegistrationInteractorToPresenterProtocol {
    func userIsSignUpWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        view.showErrorAlert(with: error.localizedDescription)
    }
    func userIsSingUp() {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        router.navigateToMainPage()
    }
}
