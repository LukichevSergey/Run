//
//  DetailTrainingPresenter.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import Foundation
import UIKit

// MARK: Protocol - DetailTrainingViewToPresenterProtocol (View -> Presenter)
protocol DetailTrainingViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: Protocol - DetailTrainingInteractorToPresenterProtocol (Interactor -> Presenter)
protocol DetailTrainingInteractorToPresenterProtocol: AnyObject {

    func trainingIsFetchedWithError(error: Error)
}

final class DetailTrainingPresenter {
    
    // MARK: Properties
    var router: DetailTrainingPresenterToRouterProtocol!
    var interactor: DetailTrainingPresenterToInteractorProtocol!
    weak var view: DetailTrainingPresenterToViewProtocol!
    
    weak var progressBar: ProgressBarViewProtocol?
}

// MARK: Extension - DetailTrainingViewToPresenterProtocol
extension DetailTrainingPresenter: DetailTrainingViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
    }
}

// MARK: Extension - DetailTrainingInteractorToPresenterProtocol
extension DetailTrainingPresenter: DetailTrainingInteractorToPresenterProtocol {
    
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
