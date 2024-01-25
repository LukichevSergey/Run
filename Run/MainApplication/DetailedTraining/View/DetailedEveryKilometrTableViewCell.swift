//
//  DetailedEveryKilometrTableView.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.11.2023.
//

import UIKit

final class DetailedEveryKilometrTableViewCell: UITableViewCell {
    private let viewLineSeparatorOne: UIView = {
        let viewLine = UIView()
        viewLine.backgroundColor = PaletteApp.black
        return viewLine
    }()
    private let viewLineSeparatorOTwo: UIView = {
        let viewLine = UIView()
        viewLine.backgroundColor = PaletteApp.black
        return viewLine
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private let customView: UIView = {
        let view = UIView()
        return view
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = OurFonts.fontPTSansRegular24
        label.text = Tx.Training.kilometerLayout
        return label
    }()
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(5)
        }
        contentView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        customView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(customView)
        }
        contentView.addSubview(viewLineSeparatorOne)
        viewLineSeparatorOne.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom)
            make.height.equalTo(2)
            make.width.equalToSuperview()
        }
        contentView.addSubview(viewLineSeparatorOTwo)
        viewLineSeparatorOTwo.snp.makeConstraints { make in
            make.bottom.width.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
        scrollView.alwaysBounceVertical = true
    }
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailedEveryKilometrTableViewCell: ConfigurableViewProtocol {
    func configure(with model: DetailedEveryKilometrViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        var km = 1
        model.time.forEach { timeKM in
            let containerView = UIView()
            stackView.addArrangedSubview(containerView)
            let kilometrLabel = UILabel()
            kilometrLabel.text = "\(Tx.Training.kilometr) \(km)"
            containerView.addSubview(kilometrLabel)
            kilometrLabel.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(5)
                make.centerY.equalToSuperview()
            }
            let timeLabel = UILabel()
            timeLabel.text = "\(timeKM)"
            containerView.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(5)
                make.center.equalToSuperview()
            }
            km += 1
        }
    }
}
