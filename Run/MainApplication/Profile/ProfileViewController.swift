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
    func setUsername(on name: String)
}

// MARK: Protocol - ProfileRouterToViewProtocol (Router -> View)
protocol ProfileRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Property
    var presenter: ProfileViewToPresenterProtocol!
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = OurFonts.fontPTSansBold72
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.setTitle(Tx.Profile.exit, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        return button
    }()

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
        view.backgroundColor = PaletteApp.white
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: Extension - ProfilePresenterToViewProtocol 
extension ProfileViewController: ProfilePresenterToViewProtocol{
    func setUsername(on name: String) {
        nameLabel.text = name
    }
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

private extension ProfileViewController {
    @objc private func exitButtonTapped() {
        presenter.exitButtonTapped()
    }
}
