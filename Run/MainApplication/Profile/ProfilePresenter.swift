//
//  ProfilePresenter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - ProfileViewToPresenterProtocol (View -> Presenter)
protocol ProfileViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType)
}

// MARK: Protocol - ProfileInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ProfileInteractorToPresenterProtocol: AnyObject {
    func userIsChanged()
    func userBalanceIsFetched()
}

final class ProfilePresenter {

    // MARK: Properties
    var router: ProfilePresenterToRouterProtocol!
    var interactor: ProfilePresenterToInteractorProtocol!
    weak var view: ProfilePresenterToViewProtocol!
}

// MARK: Extension - ProfileViewToPresenterProtocol
extension ProfilePresenter: ProfileViewToPresenterProtocol {
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType) {
        logger.log("\(#fileID) -> \(#function)")
        switch type {
        case .editProfile:
            router.navigateToEditProfile(with: interactor.user)
        case .exit:
            interactor.signOut()
        }
    }
    
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.subscribeOnUserChanged()
        view.setData(interactor.dataSource)
        interactor.fetchUserBalance()
    }
}

// MARK: Extension - ProfileInteractorToPresenterProtocol
extension ProfilePresenter: ProfileInteractorToPresenterProtocol {
    func userBalanceIsFetched() {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
        view.setBalance(balance: interactor.balance?.currentAmount ?? 0)
    }
    
    func userIsChanged() {
        logger.log("\(#fileID) -> \(#function)")
        view.setUsername(on: interactor.user.getName())
    }
}
