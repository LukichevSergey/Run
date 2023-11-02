//
//  DetailTrainingViewController.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import UIKit

// MARK: Protocol - DetailTrainingPresenterToViewProtocol (Presenter -> View)
protocol DetailTrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
}

// MARK: Protocol - DetailTrainingRouterToViewProtocol (Router -> View)
protocol DetailTrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class DetailTrainingViewController: UIViewController {
    
    // MARK: - Property
    var presenter: DetailTrainingViewToPresenterProtocol!
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    
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
        view.backgroundColor = PaletteApp.darkbOrange
        configureUI()
        presenter.viewDidLoad()
        
        
    }
    
    // MARK: - private func
    private func commonInit() {
        
    }
    
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white

        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
    }
}

// MARK: Extension - DetailTrainingPresenterToViewProtocol
extension DetailTrainingViewController: DetailTrainingPresenterToViewProtocol {

}

// MARK: Extension - TrainingRouterToViewProtocol
extension DetailTrainingViewController: DetailTrainingRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }

}
