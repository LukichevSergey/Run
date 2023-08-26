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

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}