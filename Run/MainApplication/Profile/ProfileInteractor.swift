//
//  ProfileInteractor.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation
import Combine
import OrderedCollections

// MARK: Protocol - ProfilePresenterToInteractorProtocol (Presenter -> Interactor)
protocol ProfilePresenterToInteractorProtocol: AnyObject {
    var user: AppUser { get }
    var balance: Balance? { get }
    var sneakers: OrderedSet<Sneakers> { get }
    var dataSource: ProfileViewModel { get }
    func fetchUserData()
    func subscribeOnUserChanged()
    func signOut()
    func selectSnakersWithId(id: String)
}

final class ProfileInteractor {
    // MARK: Properties
    weak var presenter: ProfileInteractorToPresenterProtocol!
    private let dataBase: ProfileToDatabaseServiceProtocol
    private let _dataSource: [ProfileTableViewCellViewModel.CellType]
    private var _user: AppUser
    private var _balance: Balance?
    private var _sneakers: OrderedSet<Sneakers>?
    private var store: AnyCancellable?

    init() {
        logger.log("\(#fileID) -> \(#function)")
        _user = GlobalData.userModel.value ?? .init(id: "", name: "")
        _dataSource = [.editProfile, .exit]
        dataBase = DatabaseService()
    }
}

// MARK: Extension - ProfilePresenterToInteractorProtocol
extension ProfileInteractor: ProfilePresenterToInteractorProtocol {
    var user: AppUser {
        logger.log("\(#fileID) -> \(#function)")
        return _user
    }
    var balance: Balance? {
        logger.log("\(#fileID) -> \(#function)")
        return _balance
    }
    var dataSource: ProfileViewModel {
        logger.log("\(#fileID) -> \(#function)")
        return .init(cells: _dataSource.map {.init(type: $0)})
    }
    var sneakers: OrderedSet<Sneakers> {
        logger.log("\(#fileID) -> \(#function)")
        return _sneakers ?? []
    }
    @MainActor
    func fetchUserData() {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                async let balanceTask = dataBase.getBalance(for: _user.getId())
                async let sneakersTask = dataBase.getSneakers(for: _user.getId())
                _balance = try await balanceTask
                _sneakers = try await sneakersTask
                presenter.userDataIsFetched()
            } catch {
            }
        }
    }
    @MainActor
    func selectSnakersWithId(id: String) {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                try await dataBase.setActiveSnakers(for: _user.getId(), selectedId: id)
                guard let _sneakers = self._sneakers else { return }
                let sneakers = _sneakers.map({$0.id == id ? $0.activated : $0.deactivated})
                self._sneakers = .init(sneakers)
                presenter.newSnakersIsSelected()
            } catch {
            }
        }
    }
    func subscribeOnUserChanged() {
        logger.log("\(#fileID) -> \(#function)")
        store = GlobalData.userModel.sink { [weak self] user in
            guard let user else { return }
            self?._user = user
            self?.presenter.userIsChanged()
        }
    }
    func signOut() {
        logger.log("\(#fileID) -> \(#function)")
        GlobalData.userModel.send(nil)
    }
}
