//
//  RegistrationInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - RegistrationPresenterToInteractorProtocol (Presenter -> Interactor)
protocol RegistrationPresenterToInteractorProtocol: AnyObject {
    func signUp()
    func setUsername(to username: String)
    func setEmail(to email: String)
    func setPassword(to password: String)
}

final class RegistrationInteractor {

    // MARK: Properties
    weak var presenter: RegistrationInteractorToPresenterProtocol!
    
    private var username: String = ""
    private var email: String = ""
    private var password: String = ""
}

// MARK: Extension - RegistrationPresenterToInteractorProtocol
extension RegistrationInteractor: RegistrationPresenterToInteractorProtocol {
    func setUsername(to username: String) {
        self.username = username
    }
    
    func setEmail(to email: String) {
        self.email = email
    }
    
    func setPassword(to password: String) {
        self.password = password
    }
    
    func signUp() {
        AuthManager.shared.signUp(username: username, email: email, password: password) { [weak presenter] result in
            switch result {
            case .success(let user):
                GlobalData.userModel = user
                presenter?.userIsSingUp()
            case .failure(let error):
                presenter?.userIsSignUpWithError(error: error)
            }
        }
    }
}
