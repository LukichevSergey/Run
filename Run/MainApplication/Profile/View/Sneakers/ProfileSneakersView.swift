//
//  ProfileSneakersView.swift
//  Run
//
//  Created by Сергей Лукичев on 25.09.2023.
//

import UIKit

final class ProfileSneakersView: UIView {
    
    private lazy var sneakersView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "defaultSneakers")
        view.contentMode = .scaleToFill /// Поправить (смотрится ужасно - нужна норм дефолтная картинка)
        
        return view
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "\(0) км"
        
        return label
    }()
    
    private lazy var trainingsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "\(0) трен"
        
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "\(0) ₽"
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "\(100) / 100"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        label.textAlignment = .right
        label.numberOfLines = 1
        label.text = "Lvl \(1)"
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var bottomHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [moneyLabel, conditionLabel, levelLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing

        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(sneakersView)
        sneakersView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
        }
        
        addSubview(trainingsCountLabel)
        trainingsCountLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        addSubview(bottomHStack)
        bottomHStack.snp.makeConstraints { make in
            make.bottom.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
    }
}

extension ProfileSneakersView: ConfigurableViewProtocol {
    func configure(with model: Sneakers) {
        distanceLabel.text = "\(model.distance) км"
        trainingsCountLabel.text = "\(model.trainingsCount) трен"
        moneyLabel.text = "\(model.money) ₽"
        conditionLabel.text = "\(model.condition) / 100"
        levelLabel.text = "Lvl \(model.level)"
    }
    
    typealias ConfigurationModel = Sneakers
}
