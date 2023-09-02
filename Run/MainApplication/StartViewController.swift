//
//  StartViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit

final class StartViewController: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if GlobalData.userModel == nil {
            let authView = AuthViewController()
            navigationController?.pushViewController(authView, animated: false)
        } else {
            let mainApplication = RootMainApplicitionController()
            mainApplication.modalPresentationStyle = .fullScreen
            present(mainApplication, animated: false)
        }
    }
}
