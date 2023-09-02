//
//  AppUser.swift
//  Run
//
//  Created by Лукичев Сергей on 30.08.2023.
//

import Foundation

class AppUser: Codable {

    let id: String
    var name: String
    
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
