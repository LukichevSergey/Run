//
//  ListCollectionViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 03.11.2023.
//

import UIKit
import SwipeCellKit

final class ListCollectionViewCell: SwipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
        contentView.backgroundColor = PaletteApp.lightGreen
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = PaletteApp.darkblue.cgColor
        contentView.layer.cornerRadius = 20
    }
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
    private let imageVariantRun: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private let kilomertLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    private let dateLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular14
        return label
    }()
    private let titleCellLabel: UILabel =  {
        let label = UILabel()
        label.text = Tx.Training.run
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold14
        return label
    }()
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        contentView.addSubview(imageVariantRun)
        imageVariantRun.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.left.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(10)
        }
        contentView.addSubview(titleCellLabel)
        titleCellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(60)
        }
        contentView.addSubview(kilomertLabel)
        kilomertLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(60)
        }
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(15)
        }
    }
}

extension ListCollectionViewCell: ConfigurableViewProtocol {
    func configure(with model: TrainingCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        imageVariantRun.image = model.image
        kilomertLabel.text = model.killometrs
        dateLabel.text = model.data
        titleCellLabel.text = model.title
    }
}
