//
//  DetailedResultTableViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.11.2023.
//


import UIKit

final class DetailedResultTableViewCell: UITableViewCell {
    
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
    
    private let alltimeLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.allTime
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let alltime: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.CircleTableResult.distance
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let distance: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let averageTempLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Timer.averageTemp
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let averageTemp: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")

        contentView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        customView.addSubview(alltimeLabel)
        alltimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview()
        }
        
        customView.addSubview(alltime)
        alltime.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalTo(alltimeLabel)
        }
        
        customView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        customView.addSubview(distance)
        distance.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalTo(distanceLabel)
        }
        
        customView.addSubview(averageTempLabel)
        averageTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(5)
        }
        
        customView.addSubview(averageTemp)
        averageTemp.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalTo(averageTempLabel)
        }
        
        contentView.addSubview(viewLineSeparatorOne)
        viewLineSeparatorOne.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).inset(0)
            make.height.equalTo(2)
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(viewLineSeparatorOTwo)
        viewLineSeparatorOTwo.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalToSuperview()
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

extension DetailedResultTableViewCell: ConfigurableViewProtocol {
    func configure(with model: DetailedResultViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        alltime.text = model.allTimeTraining
        distance.text = model.distanse
        averageTemp.text = model.averageTemp
    }
}
