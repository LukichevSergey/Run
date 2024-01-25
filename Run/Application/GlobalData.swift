//
//  GlobalData.swift
//  Run
//
//  Created by Лукичев Сергей on 31.08.2023.
//

import UIKit
import Combine
import FirebaseAuth

let GlobalData = GlobalDataContainer.shared

final class GlobalDataContainer {
    static let shared = GlobalDataContainer()
    private let userDefault = UserDefaults.standard
    private var store: AnyCancellable?
    private init() {
        logger.log("\(#fileID) -> \(#function)")
        let userDefault = UserDefaults.standard
        do {
            if let data = userDefault.object(forKey: "userModel") as? Data,
               let profile = try? JSONDecoder().decode(AppUser.self, from: data) {
                userModel.send(profile)
            } else {
                userModel.send(nil)
            }
            subscribeOnUser()
        }
    }
    let userModel = CurrentValueSubject<AppUser?, Never>(nil)
    private func subscribeOnUser() {
        logger.log("\(#fileID) -> \(#function)")
        store = userModel.sink { [weak self] _ in
            self?.saveUser()
        }
    }
    private func saveUser() {
        logger.log("\(#fileID) -> \(#function)")
        if let encoded = try? JSONEncoder().encode(userModel.value) {
            userDefault.set(encoded, forKey: "userModel")
        } else {
            userDefault.set(nil, forKey: "userModel")
        }
    }
}
