//
//  DictionaryConvertible.swift
//  Run
//
//  Created by Сергей Лукичев on 25.09.2023.
//

import Foundation

protocol DictionaryConvertible {
    init?(from dictionary: [String: Any])
    var toDict: [String: Any] { get }
}
