//
//  RegistrationViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import UIKit

// MARK: Protocol - RegistrationPresenterToViewProtocol (Presenter -> View)
protocol RegistrationPresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - RegistrationRouterToViewProtocol (Router -> View)
protocol RegistrationRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class RegistrationViewController: UIViewController {
    
    // MARK: - Property
    var presenter: RegistrationViewToPresenterProtocol!
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = PaletteApp.lightGreen.cgColor
        textField.tag = 1
        textField.delegate = self

        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = PaletteApp.lightGreen.cgColor
        textField.tag = 2
        textField.delegate = self

        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16
        button.backgroundColor = PaletteApp.lightGreen
        button.setTitleColor(PaletteApp.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
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

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        view.backgroundColor = PaletteApp.white
        
        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        [usernameTextField, passwordTextField, authButton].forEach { item in
            item.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            mainVStack.addArrangedSubview(item)
        }
    }
    
    @objc private func authButtonTapped() {
        presenter.authButtonTapped()
    }
}

// MARK: Extension - RegistrationPresenterToViewProtocol 
extension RegistrationViewController: RegistrationPresenterToViewProtocol{
    
}

// MARK: Extension - RegistrationRouterToViewProtocol
extension RegistrationViewController: RegistrationRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            presenter.emailIsChanged(to: textField.text ?? "")
        case 2:
            presenter.passwordIsChanged(to: textField.text ?? "")
        default: return
        }
    }
}
