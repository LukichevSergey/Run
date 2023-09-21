//
//  TrainingViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import UIKit

// MARK: Protocol - TrainingPresenterToViewProtocol (Presenter -> View)
protocol TrainingPresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - TrainingRouterToViewProtocol (Router -> View)
protocol TrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class TrainingViewController: UIViewController {
    
    // MARK: - Property
    var presenter: TrainingViewToPresenterProtocol!

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = .systemCyan
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {

    }
}

// MARK: Extension - TrainingPresenterToViewProtocol 
extension TrainingViewController: TrainingPresenterToViewProtocol{
    
}

// MARK: Extension - TrainingRouterToViewProtocol
extension TrainingViewController: TrainingRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}
