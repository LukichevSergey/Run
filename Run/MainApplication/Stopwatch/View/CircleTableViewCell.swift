//
//  CircleTableViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 03.09.2023.
//

import UIKit

final class CircleTableViewCell: UITableViewCell {
    private let circleLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    private let distancseLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        contentView.addSubview(circleLabel)
        circleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(10)
        }

        contentView.addSubview(distancseLabel)
        distancseLabel.snp.makeConstraints { make in
            make.top.equalTo(circleLabel)
            make.leading.equalTo(circleLabel.snp.trailing).offset(40) // Отступ справа от circleLabel
        }

        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(distancseLabel)
            make.leading.equalTo(distancseLabel.snp.trailing).offset(40) // Отступ справа от distancseLabel
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
}

extension CircleTableViewCell: ConfigurableViewProtocol {
    func configure(with model: CircleViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        circleLabel.text = model.circle
        distancseLabel.text = model.distance
        timeLabel.text = model.time
    }
}
