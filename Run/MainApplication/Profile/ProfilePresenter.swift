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
    func viewDidAppear()
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType)
    func snakersIsSelected(with id: String)
}

// MARK: Protocol - ProfileInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ProfileInteractorToPresenterProtocol: AnyObject {
    func userIsChanged()
    func userDataIsFetched()
    func newSnakersIsSelected()
}

final class ProfilePresenter {

    // MARK: Properties
    var router: ProfilePresenterToRouterProtocol!
    var interactor: ProfilePresenterToInteractorProtocol!
    weak var view: ProfilePresenterToViewProtocol!
}

// MARK: Extension - ProfileViewToPresenterProtocol
extension ProfilePresenter: ProfileViewToPresenterProtocol {
    func snakersIsSelected(with id: String) {
        logger.log("\(#fileID) -> \(#function)")
        
        view.showActivityIndicator()
        interactor.selectSnakersWithId(id: id)
    }
    
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
        interactor.subscribeOnUserChanged()
        view.setData(interactor.dataSource)
    }
    
    func viewDidAppear() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchUserData()
    }
}

// MARK: Extension - ProfileInteractorToPresenterProtocol
extension ProfilePresenter: ProfileInteractorToPresenterProtocol {
    func userDataIsFetched() {
        logger.log("\(#fileID) -> \(#function)")
        view.setBalance(balance: interactor.balance?.currentAmount ?? 0)
        view.setSneakers(interactor.sneakers)
        
        view.removeActivityIndicator()
    }
    
    func userIsChanged() {
        logger.log("\(#fileID) -> \(#function)")
        view.setUsername(on: interactor.user.getName())
    }
    
    func newSnakersIsSelected() {
        logger.log("\(#fileID) -> \(#function)")
        
        view.setSneakers(interactor.sneakers)
        view.removeActivityIndicator()
    }
}
