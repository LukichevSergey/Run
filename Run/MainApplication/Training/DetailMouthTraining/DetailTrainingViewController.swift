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

}

final class DetailTrainingViewController: UIViewController {
    
    // MARK: - Property
    var presenter: DetailTrainingViewToPresenterProtocol!
    
    
    
    // MARK: - init
    
    override func viewWillAppear(_ animated: Bool) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.viewDidLoad()
    }
    
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
        view.backgroundColor = PaletteApp.white
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {
        
    }
    
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        
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
