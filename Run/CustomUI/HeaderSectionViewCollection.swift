//
//  HeaderSectionViewCollection.swift
//  Run
//
//  Created by Evgenii Kutasov on 05.11.2023.
//

import Foundation
import UIKit


final class HeaderSectionViewCollection: UICollectionReusableView {
    

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
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let textTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Всего"
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16

        return label
    }()
    
    private let textAverageLabel: UILabel = {
        let label = UILabel()
        label.text = "in Average"
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16

        return label
    }()
    
    private let textTrainingLabel: UILabel =  {
        let label = UILabel()
        label.text = Tx.Training.title
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let trainingCountLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let textTimeLabel: UILabel =  {
        let label = UILabel()
        label.text = Tx.Timer.subtitle
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let allTimeLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let allAverageLabel: UILabel =  {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        
        addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(0)
        }
        
        addSubview(textTotalLabel)
        textTotalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(130)
        }
        
        addSubview(textAverageLabel)
        textAverageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.left.equalTo(textTotalLabel.snp.left).inset(50)
        }
        
        addSubview(textTrainingLabel)
        textTrainingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(5)
        }
        
        addSubview(trainingCountLabel)
        trainingCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(140)
        }
        
        addSubview(textTimeLabel)
        textTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(5)
        }
        
        addSubview(allTimeLabel)
        allTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalTo(center).inset(130)
        }
        
        addSubview(allAverageLabel)
        allAverageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalTo(allTimeLabel.snp.left).inset(50)
        }
    }
}

extension HeaderSectionViewCollection: ConfigurableViewProtocol {
    func configure(with model: HeaderDetailTrainingViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        trainingCountLabel.text = "\(model.countTraining)"
        allTimeLabel.text = "\(model.allTime)"
        allAverageLabel.text = "\(model.averageTime)"
        monthLabel.text = "\(model.month)"
    }
}
