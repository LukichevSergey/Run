//
//  AuthViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 28.08.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private lazy var titleView: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.text = "GO RUN"
        label.font = OurFonts.fontPTSansBold32

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4

        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Auth.signIn, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Auth.signUp, for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, authButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 24
        
        return stack
    }()
    
    func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        titleView.backgroundColor = PaletteApp.lightGreen
        
        navigationItem.hidesBackButton = true
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        view.addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        [loginButton, authButton].forEach { button in
            button.layer.cornerRadius = 24
            button.titleLabel?.font = OurFonts.fontPTSansRegular20
            button.setTitleColor(PaletteApp.black, for: .normal)
            button.backgroundColor = PaletteApp.lightOrange
            button.layer.masksToBounds = false
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.5
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 4
            button.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(50)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("\(#fileID) -> \(#function)")
        configureUI()
    }
    
    @objc private func loginButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        let loginVC = LoginConfigurator().configure()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func authButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        let regVC = RegistrationConfigurator().configure()
        navigationController?.pushViewController(regVC, animated: true)
    }
}
