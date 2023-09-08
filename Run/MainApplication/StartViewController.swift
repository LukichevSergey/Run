//
//  StartViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit
import Combine

final class StartViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        GlobalData.userModel
            .dropFirst()
            .sink { [weak self] userModel in
            
                if userModel == nil {
                    self?.navigationController?.presentedViewController?.dismiss(animated: false)
                    self?.navigationController?.setViewControllers([StartViewController()], animated: false)
                }
            }.store(in: &subscriptions)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if GlobalData.userModel.value == nil {
            let authView = AuthViewController()
            navigationController?.pushViewController(authView, animated: false)
        } else {
            let mainApplication = RootMainApplicitionController()
            mainApplication.modalPresentationStyle = .fullScreen
            present(mainApplication, animated: false)
        }
    }
}
