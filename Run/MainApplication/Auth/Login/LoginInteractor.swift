//
//  LoginInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import Foundation

// MARK: Protocol - LoginPresenterToInteractorProtocol (Presenter -> Interactor)
protocol LoginPresenterToInteractorProtocol: AnyObject {
    func fetchLoginData()
    func setEmail(to email: String)
    func setPassword(to password: String)
}

class LoginInteractor {

    // MARK: Properties
    weak var presenter: LoginInteractorToPresenterProtocol!
    
    private var email: String = ""
    private var password: String = ""
}

// MARK: Extension - LoginPresenterToInteractorProtocol
extension LoginInteractor: LoginPresenterToInteractorProtocol {
    func setEmail(to email: String) {
        self.email = email
    }
    
    func setPassword(to password: String) {
        self.password = password
    }
    
    func fetchLoginData() {
        AuthManager.shared.signIn(email: email, password: password) { [weak presenter] result in
            switch result {
            case .success(let user):
                GlobalData.userModel = user
                presenter?.userIsSingIn()
            case .failure(let error):
                presenter?.userIsSignInWithError(error: error)
            }
        }
    }
}
