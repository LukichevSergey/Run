//
//  EditProfileViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//  
//

import UIKit

// MARK: Protocol - EditProfilePresenterToViewProtocol (Presenter -> View)
protocol EditProfilePresenterToViewProtocol: AnyObject {
    func setTextField(with data: String)
    func showErrorAlert(with text: String)
    func showActivityIndicator()
    func removeActivityIndicator()
}

// MARK: Protocol - EditProfileRouterToViewProtocol (Router -> View)
protocol EditProfileRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
    func popView()
}

final class EditProfileViewController: UIViewController {
    
    // MARK: - Property
    var presenter: EditProfileViewToPresenterProtocol!
    
    private lazy var usernameTextField: TextFieldInterface = {
        let textField = AuthTextField(with: .name)
        textField.delegate = self

        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16
        button.backgroundColor = PaletteApp.lightGreen
        button.setTitleColor(PaletteApp.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

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
        
        [usernameTextField, saveButton].forEach { item in
            item.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            mainVStack.addArrangedSubview(item)
        }
    }
    
    @objc private func saveButtonTapped() {
        presenter.saveButtonTapped()
    }
}

// MARK: Extension - EditProfilePresenterToViewProtocol 
extension EditProfileViewController: EditProfilePresenterToViewProtocol{
    func showErrorAlert(with text: String) {
        showAlert(with: text)
    }
    
    func setTextField(with data: String) {
        usernameTextField.setText(text: data)
    }
}

// MARK: Extension - EditProfileRouterToViewProtocol
extension EditProfileViewController: EditProfileRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Extension - UITextFieldDelegate
extension EditProfileViewController: AuthTextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            presenter.userNameTextFieldIsChanged(on: textField.text ?? "")
        default: return
        }
    }
}
