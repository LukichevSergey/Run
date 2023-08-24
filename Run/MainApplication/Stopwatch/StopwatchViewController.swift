//
//  StopwatchViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit

// MARK: Protocol - StopwatchPresenterToViewProtocol (Presenter -> View)
protocol StopwatchPresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - StopwatchRouterToViewProtocol (Router -> View)
protocol StopwatchRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class StopwatchViewController: UIViewController {
    
    // MARK: - Property
    var presenter: StopwatchViewToPresenterProtocol!

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
        view.backgroundColor = .systemGreen
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {

    }
}

// MARK: Extension - StopwatchPresenterToViewProtocol 
extension StopwatchViewController: StopwatchPresenterToViewProtocol{
    
}

// MARK: Extension - StopwatchRouterToViewProtocol
extension StopwatchViewController: StopwatchRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
