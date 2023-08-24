//
//  RoundButton.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit

protocol RoundButtonDelegate: AnyObject {
    func roundButtonTapped(with type: RoundButton.RoundButtonStatus)
}

final class RoundButton: UIView {
    
    enum RoundButtonStatus {
        case startButton(isStarted: Bool)
        case endButton
        
        var size: CGFloat {
            switch self {
            case .startButton: return 72
            case .endButton: return 36
            }
        }
        
        var image: UIImage? {
            switch self {
            case .startButton: return UIImage(systemName: "play.fill")
            default: return UIImage()
            }
        }
    }
    
    weak var delegate: RoundButtonDelegate?
    private var status: RoundButtonStatus
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(status.image, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: status.size, weight: .bold), forImageIn: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    init(status: RoundButtonStatus) {
        self.status = status
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        self.status = .startButton(isStarted: false)
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.status = .startButton(isStarted: false)
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    func configure() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc private func buttonTapped() {
        switch status {
        case .startButton(let isStarted):
            self.status = isStarted ? .startButton(isStarted: false) : .startButton(isStarted: true)
        case .endButton:
            return
        }
        
        delegate?.roundButtonTapped(with: status)
    }
}
