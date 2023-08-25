//
//  ConfigurableViewProtocol.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import Foundation

protocol ConfigurableViewProtocol {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
