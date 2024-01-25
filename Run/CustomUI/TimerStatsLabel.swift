//
//  TimerStatsLabel.swift
//  Run
//
//  Created by Лукичев Сергей on 25.08.2023.
//

import UIKit

final class TimerStatsLabel: UIView {
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        label.textAlignment = .center
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        label.textAlignment = .center
        return label
    }()
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dataLabel, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}

extension TimerStatsLabel: ConfigurableViewProtocol {

    typealias ConfigurationModel = TimerStatsViewModel

    func configure(with model: TimerStatsViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        dataLabel.text = model.data
        descriptionLabel.text = model.description
    }
}
