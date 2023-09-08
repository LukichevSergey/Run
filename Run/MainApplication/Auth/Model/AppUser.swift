//
//  AppUser.swift
//  Run
//
//  Created by Лукичев Сергей on 30.08.2023.
//

import Foundation

final class AppUser: Codable {

    private let id: String
    private var name: String
    
    func setName(on name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return name
    }
    
    func getId() -> String {
        return id
    }
    
    internal init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    var toDict: [String: Any] {
        var dict:[String: Any] = [:]
        dict["id"] = id
        dict["name"] = name
        
        return dict
    }
}
