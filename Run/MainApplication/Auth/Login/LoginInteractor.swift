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

final class LoginInteractor {

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
    
    @MainActor
    func fetchLoginData() {
        Task {
            do {
                let userResult = try await AuthManager.shared.signIn(email: email, password: password)
                let user = try await DatabaseService.shared.getUser(with: userResult.user.uid)
                GlobalData.userModel.send(user)
                presenter?.userIsSingIn()
            } catch {
                GlobalData.userModel.send(nil)
                presenter?.userIsSignInWithError(error: error)
            }
        }
    }
}
