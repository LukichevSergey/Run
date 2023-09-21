//
//  LoginViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 29.08.2023.
//  
//

import UIKit

// MARK: Protocol - LoginPresenterToViewProtocol (Presenter -> View)
protocol LoginPresenterToViewProtocol: AnyObject {
    func showErrorAlert(with text: String)
    func showActivityIndicator()
    func removeActivityIndicator()
}

// MARK: Protocol - LoginRouterToViewProtocol (Router -> View)
protocol LoginRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
    func popView()
}

final class LoginViewController: UIViewController {
    
    // MARK: - Property
    var presenter: LoginViewToPresenterProtocol!
    
    private lazy var emailTextField: AuthTextField = {
        let textField = AuthTextField(with: .email)
        textField.delegate = self

        return textField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(with: .password)
        textField.delegate = self

        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Tx.Auth.signIn, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16
        button.backgroundColor = PaletteApp.lightGreen
        button.setTitleColor(PaletteApp.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

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
        configureUI()
        presenter.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - private func
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
    }

    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        
        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        [emailTextField, passwordTextField, loginButton].forEach { item in
            item.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            mainVStack.addArrangedSubview(item)
        }
    }
    
    @objc private func loginButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.loginButtonTapped()
    }
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        logger.log("\(#fileID) -> \(#function)")
        view.endEditing(false)
    }
}

// MARK: Extension - LoginPresenterToViewProtocol 
extension LoginViewController: LoginPresenterToViewProtocol{
    func showErrorAlert(with text: String) {
        logger.log("\(#fileID) -> \(#function)")
        showAlert(with: text)
    }
}

// MARK: Extension - LoginRouterToViewProtocol
extension LoginViewController: LoginRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
    
    func popView() {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.popViewController(animated: false)
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: AuthTextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        logger.log("\(#fileID) -> \(#function)")
        switch textField.tag {
        case 1:
            presenter.emailIsChanged(to: textField.text ?? "")
        case 2:
            presenter.passwordIsChanged(to: textField.text ?? "")
        default: return
        }
    }
}
