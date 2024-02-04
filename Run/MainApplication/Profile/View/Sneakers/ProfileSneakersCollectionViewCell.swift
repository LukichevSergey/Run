//
//  ProfileSneakersCollectionViewCell.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import UIKit

private enum Constants {
    static var imageInset: CGFloat = 16
    static var labelsInset: CGFloat = 8
    static var labelsTextColor: UIColor = PaletteApp.black
    static var labelsTextFont: UIFont = OurFonts.fontPTSansBold14
}

final class ProfileSneakersCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ProfileSneakersCollectionViewCell.self)
    private lazy var sneakersView: UIImageView = {
        let view = UIImageView()
        view.image = ListImages.Profile.defaultSneakers
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelsTextColor
        label.font = Constants.labelsTextFont
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    private lazy var trainingsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelsTextColor
        label.font = Constants.labelsTextFont
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    private lazy var isActiveLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.lightGreen
        label.font = OurFonts.fontPTSansBold16
        label.text = "Selected"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    private lazy var topHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [distanceLabel, isActiveLabel, trainingsCountLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing

        return stack
    }()
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelsTextColor
        label.font = Constants.labelsTextFont
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelsTextColor
        label.font = Constants.labelsTextFont
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelsTextColor
        label.font = Constants.labelsTextFont
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    private lazy var bottomHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [moneyLabel, conditionLabel, levelLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing

        return stack
    }()
    private func commonInit() {
        backgroundColor = PaletteApp.white
        addSubview(sneakersView)
        sneakersView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Constants.imageInset)
        }

        addSubview(topHStack)
        topHStack.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(Constants.labelsInset)
        }

        addSubview(bottomHStack)
        bottomHStack.snp.makeConstraints { make in
            make.bottom.directionalHorizontalEdges.equalToSuperview().inset(Constants.labelsInset)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension ProfileSneakersCollectionViewCell: ConfigurableViewProtocol {
    func configure(with model: Sneakers) {
        distanceLabel.text = "\(model.distance) \(Tx.Timer.kilometr)"
        trainingsCountLabel.text = "\(model.trainingsCount) \(Tx.Profile.currency)"
        moneyLabel.text = "\(model.money) ₽"
        conditionLabel.text = "\(model.condition) / 100"
        levelLabel.text = "Lvl \(model.level)"
        isActiveLabel.isHidden = !model.isActive
    }
}
