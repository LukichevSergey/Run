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
    
    private init() {
        let userDefault = UserDefaults.standard
        
        userModel = {
            if let data = userDefault.object(forKey: "userModel") as? Data,
               let profile = try? JSONDecoder().decode(AppUser.self, from: data) { return profile }

            return nil
        }()
    }
    
    @Published var userModel: AppUser? {
        didSet {
            if let encoded = try? JSONEncoder().encode(userModel) {
                userDefault.set(encoded, forKey: "userModel")
            } else {
                userDefault.set(nil, forKey: "userModel")
            }
        }
    }
}
