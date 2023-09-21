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
        
        [usernameTextField, saveButton].forEach { item in
            item.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            mainVStack.addArrangedSubview(item)
        }
    }
    
    @objc private func saveButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.saveButtonTapped()
    }
}

// MARK: Extension - EditProfilePresenterToViewProtocol 
extension EditProfileViewController: EditProfilePresenterToViewProtocol{
    func showErrorAlert(with text: String) {
        logger.log("\(#fileID) -> \(#function)")
        showAlert(with: text)
    }
    
    func setTextField(with data: String) {
        logger.log("\(#fileID) -> \(#function)")
        usernameTextField.setText(text: data)
    }
}

// MARK: Extension - EditProfileRouterToViewProtocol
extension EditProfileViewController: EditProfileRouterToViewProtocol{
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
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Extension - UITextFieldDelegate
extension EditProfileViewController: AuthTextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        logger.log("\(#fileID) -> \(#function)")
        switch textField.tag {
        case 0:
            presenter.userNameTextFieldIsChanged(on: textField.text ?? "")
        default: return
        }
    }
}
