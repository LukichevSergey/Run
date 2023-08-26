//
//  RoundButton.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit

protocol RoundButtonDelegate: AnyObject {
    func roundButtonTapped(with type: RoundButton.RoundButtonType)
}

final class RoundButton: UIView {
    
    enum RoundButtonType {
        case startButton(isStarted: Bool)
        case endButton
        case roundButton
        
        var size: CGFloat {
            switch self {
            case .startButton: return 54
            case .endButton, .roundButton: return 36
            }
        }
        
        var image: UIImage? {
            switch self {
            case .startButton(isStarted: false): return UIImage(systemName: "play.fill")
            case .startButton(isStarted: true): return UIImage(systemName: "pause.fill")
            default: return UIImage()
            }
        }
        
        var frameSize: CGFloat {
            switch self {
            case .startButton: return 100
            case .endButton, .roundButton: return 65
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .startButton: return PaletteApp.green
            case .endButton: return PaletteApp.red
            case .roundButton: return PaletteApp.yellow
            }
        }
        
        var tintColor: UIColor {
            switch self {
            case .startButton: return PaletteApp.black
            case .endButton: return PaletteApp.black
            case .roundButton: return PaletteApp.black
            }
        }
    }
    
    weak var delegate: RoundButtonDelegate?
    private var type: RoundButtonType
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = type.tintColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = type.backgroundColor
        
        switch type {
        case .startButton(let isStarted):
            button.setImage(type.image, for: .normal)
            button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: type.size, weight: .bold), forImageIn: .normal)
        case .endButton:
            button.setTitle("Конец", for: .normal)
            button.setTitleColor(type.tintColor, for: .normal)
        case .roundButton:
            button.setTitle("Круг", for: .normal)
            button.setTitleColor(type.tintColor, for: .normal)
        }
        
        return button
    }()
    
    init(with type: RoundButtonType) {
        self.type = type
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        self.type = .startButton(isStarted: false)
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.type = .startButton(isStarted: false)
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(type.frameSize)
            make.directionalEdges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.layer.cornerRadius = bounds.height / 2
        button.clipsToBounds = true
    }
    
    @objc private func buttonTapped() {
        switch type {
        case .startButton(let isStarted):
            self.type = isStarted ? .startButton(isStarted: false) : .startButton(isStarted: true)
            self.button.setImage(type.image, for: .normal)
        case .endButton, .roundButton:
            break
        }
        
        delegate?.roundButtonTapped(with: type)
    }
}
