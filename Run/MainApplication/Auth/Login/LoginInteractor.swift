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
    private let dataBase: LoginToDatabaseServiceProtocol
    private var email: String = ""
    private var password: String = ""
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - LoginPresenterToInteractorProtocol
extension LoginInteractor: LoginPresenterToInteractorProtocol {
    func setEmail(to email: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.email = email
    }
    func setPassword(to password: String) {
        logger.log("\(#fileID) -> \(#function)")
        self.password = password
    }
    @MainActor
    func fetchLoginData() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let userResult = try await AuthManager.shared.signIn(email: email, password: password)
                let user = try await dataBase.getUser(with: userResult.user.uid)
                GlobalData.userModel.send(user)
                presenter?.userIsSingIn()
            } catch {
                GlobalData.userModel.send(nil)
                presenter?.userIsSignInWithError(error: error)
            }
        }
    }
}
