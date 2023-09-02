//
//  ProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - ProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol ProfilePresenterToInteractorProtocol: AnyObject {
    func signOut()
}

final class ProfileInteractor {

    // MARK: Properties
    weak var presenter: ProfileInteractorToPresenterProtocol!

}

// MARK: Extension - ProfilePresenterToInteractorProtocol
extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    func signOut() {
        
    }
}
