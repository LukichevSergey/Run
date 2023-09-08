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
    
    @MainActor
    func signUp() {
        Task {
            do {
                let user = try await AuthManager.shared.signUp(username: username, email: email, password: password)
                try await DatabaseService.shared.setUser(user: user)
                try await DatabaseService.shared.setBalance(balance: Balance(userId: user.getId()))
                try await DatabaseService.shared.setSneakers(sneakers: Sneakers(userId: user.getId()))
                GlobalData.userModel.send(user)
                presenter?.userIsSingUp()
            } catch {
                GlobalData.userModel.send(nil)
                presenter?.userIsSignUpWithError(error: error)
            }
        }
    }
}
