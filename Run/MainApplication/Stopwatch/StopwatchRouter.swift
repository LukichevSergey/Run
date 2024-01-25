//
//  StopwatchRouter.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import Foundation

// MARK: Protocol - StopwatchPresenterToRouterProtocol (Presenter -> Router)
protocol StopwatchPresenterToRouterProtocol: AnyObject {

}

final class StopwatchRouter {

    // MARK: Properties
    weak var view: StopwatchRouterToViewProtocol!
}

// MARK: Extension - StopwatchPresenterToRouterProtocol
extension StopwatchRouter: StopwatchPresenterToRouterProtocol {
}
