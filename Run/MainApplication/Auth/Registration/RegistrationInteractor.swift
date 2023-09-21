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
        logger.log("\(#fileID) -> \(#function)")
        self.username = username
    }
    
    func setEmail(to email: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.email = email
    }
    
    func setPassword(to password: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.password = password
    }
    
    @MainActor
    func signUp() {
        logger.log("\(#fileID) -> \(#function)")
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
