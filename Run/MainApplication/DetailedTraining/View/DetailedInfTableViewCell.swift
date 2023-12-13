//
//  DetailedInfoTableViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 24.11.2023.
//

import UIKit

final class DetailedInfoTableViewCell: UITableViewCell {
    
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

    private let customView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let timeStartStopLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let imageActivity: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        contentView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        customView.addSubview(imageActivity)
        imageActivity.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.left.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(10)
        }
        
        customView.addSubview(activityLabel)
        activityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        customView.addSubview(targetLabel)
        targetLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalTo(activityLabel.snp.left)
        }
        
        customView.addSubview(timeStartStopLabel)
        timeStartStopLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalTo(targetLabel.snp.left)
        }
        
        customView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.equalTo(timeStartStopLabel.snp.left)
        }
        
        contentView.addSubview(viewLineSeparatorOne)
        viewLineSeparatorOne.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).inset(0)
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
    }
    
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailedInfoTableViewCell: ConfigurableViewProtocol {
    func configure(with model: DetailedInfoViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        activityLabel.text = model.activityTraining
        imageActivity.image = model.image
        targetLabel.text = model.target
        timeStartStopLabel.text = model.timeStartStop
        cityLabel.text = model.city
    }
}
