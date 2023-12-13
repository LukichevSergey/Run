//
//  TrainingTableViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import UIKit

final class TrainingTableViewCell: UITableViewCell {

    private let castomView: UIView = {
        let view = UIView()
        view.backgroundColor = PaletteApp.lightGreen
        view.layer.cornerRadius = 20
        view.layer.borderColor = PaletteApp.darkblue.cgColor
        view.layer.borderWidth = 2

        return view
    }()

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
        contentView.addSubview(castomView)
        castomView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(5)
            make.height.equalTo(70)
        }

        castomView.addSubview(imageVariantRun)
        imageVariantRun.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(10)
        }

        castomView.addSubview(titleCellLabel)
        titleCellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(60)
        }

        castomView.addSubview(kilomertLabel)
        kilomertLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(60)
        }

        castomView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(15)
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

extension TrainingTableViewCell: ConfigurableViewProtocol {
    func configure(with model: TrainingCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        imageVariantRun.image = model.image
        kilomertLabel.text = model.killometrs
        dateLabel.text = model.data
        titleCellLabel.text = model.title
    }
}
