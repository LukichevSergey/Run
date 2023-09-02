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
    func setEmail(to email: String)
    func setPassword(to password: String)
}

class RegistrationInteractor {

    // MARK: Properties
    weak var presenter: RegistrationInteractorToPresenterProtocol!
    
    private var email: String = ""
    private var password: String = ""
}

// MARK: Extension - RegistrationPresenterToInteractorProtocol
extension RegistrationInteractor: RegistrationPresenterToInteractorProtocol {
    func setEmail(to email: String) {
        self.email = email
    }
    
    func setPassword(to password: String) {
        self.password = password
    }
    
    func signUp() {
        AuthManager.shared.signUp(email: email, password: password) { [weak presenter] result in
            switch result {
            case .success(let user):
                GlobalData.userModel = user
                presenter?.userIsSingUp()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
