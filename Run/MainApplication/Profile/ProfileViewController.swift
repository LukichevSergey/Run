//
//  ProfileViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit

// MARK: Protocol - ProfilePresenterToViewProtocol (Presenter -> View)
protocol ProfilePresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - ProfileRouterToViewProtocol (Router -> View)
protocol ProfileRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class ProfileViewController: UIViewController {
    
    // MARK: - Property
    var presenter: ProfileViewToPresenterProtocol!

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
        view.backgroundColor = .systemYellow
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {

    }
}

// MARK: Extension - ProfilePresenterToViewProtocol 
extension ProfileViewController: ProfilePresenterToViewProtocol{
    
}

// MARK: Extension - ProfileRouterToViewProtocol
extension ProfileViewController: ProfileRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
