//
//  AuthTextField.swift
//  Run
//
//  Created by Лукичев Сергей on 05.09.2023.
//

import UIKit

protocol AuthTextFieldDelegate: AnyObject {
    func textFieldDidChangeSelection(_ textField: UITextField)
}

final class AuthTextField: UIView {
    
    weak var delegate: AuthTextFieldDelegate?
    
    enum TextFieldType {
        case name, email, password
        
        var placeholderText: String {
            switch self {
            case .name: return Tx.Auth.name
            case .email: return "Email"
            case .password: return "Password"
            }
        }
        
        var tag: Int {
            switch self {
            case .name: return 0
            case .email: return 1
            case .password: return 2
            }
        }
    }
    
    private var type: TextFieldType = .email
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = PaletteApp.black
        textField.textColor = PaletteApp.black
        textField.layer.borderColor = PaletteApp.lightGreen.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.autocapitalizationType = .none
        textField.tag = type.tag
        textField.backgroundColor = PaletteApp.white
        textField.attributedPlaceholder = NSAttributedString(string: type.placeholderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        if type == .password {
            var configuration = UIButton.Configuration.bordered()
            configuration.baseBackgroundColor = .clear
            let rightButton  = UIButton(configuration: configuration)
            rightButton.setImage(UIImage(systemName: "eye"), for: .normal)
            rightButton.tintColor = PaletteApp.lightGreen
            rightButton.frame = CGRect(x:0, y:0, width:30, height:30)
            rightButton.addTarget(self, action: #selector(passwordHideButtonTapped), for: .touchUpInside)
            textField.rightViewMode = .always
            textField.rightView = rightButton
            textField.isSecureTextEntry = true
        }
        
        textField.delegate = self

        return textField
    }()
    
    init(with type: TextFieldType) {
        super.init(frame: .zero)
        self.type = type
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    @objc private func passwordHideButtonTapped() {
        textField.isSecureTextEntry.toggle()
    }
}

extension AuthTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldDidChangeSelection(textField)
    }
}
