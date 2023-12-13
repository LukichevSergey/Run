//
//  ListHeaderCollectionView.swift
//  Run
//
//  Created by Evgenii Kutasov on 05.11.2023.
//

import UIKit

final class ListHeaderCollectionView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold24
        
        return label
    }()
    
    private let textTotalLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.totalTime
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
    }()
    
    private let textAverageLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.allAverageTime
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
    }()
    
    private let textTrainingLabel: UILabel =  {
        let label = UILabel()
        label.text = Tx.Training.title
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let trainingCountLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let textTimeLabel: UILabel =  {
        let label = UILabel()
        label.text = Tx.Timer.subtitle
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let allTimeLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private let allAverageLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        
        return label
    }()
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        
        addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(0)
        }
        
        addSubview(textTotalLabel)
        textTotalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalTo(monthLabel.snp.trailing).inset(10)
        }
        
        addSubview(textAverageLabel)
        textAverageLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(30)
        }
        
        addSubview(textTrainingLabel)
        textTrainingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.equalToSuperview().inset(5)
        }
        
        addSubview(trainingCountLabel)
        trainingCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalTo(textTotalLabel)
        }
        
        addSubview(textTimeLabel)
        textTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.leading.equalToSuperview().inset(5)
        }
        
        addSubview(allTimeLabel)
        allTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.centerX.equalTo(textTotalLabel)
        }
        
        addSubview(allAverageLabel)
        allAverageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.centerX.equalTo(textAverageLabel)
        }
    }
}

extension ListHeaderCollectionView: ConfigurableViewProtocol {
    func configure(with model: SectionListTrainingModel) {
        logger.log("\(#fileID) -> \(#function)")
        trainingCountLabel.text = "\(model.countTraining)"
        allTimeLabel.text = "\(model.allTime)"
        allAverageLabel.text = "\(model.averageTime)"
        monthLabel.text = "\(model.month)"
    }
}
