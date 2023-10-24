//
//  HeaderTrainingTableView.swift
//  Run
//
//  Created by Evgenii Kutasov on 18.10.2023.
//

import UIKit

class HeaderTrainingTableView: UIView {
            
    private let trainingLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.title
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
    }()
    
    private let trainingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Training.allTraining, for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansRegular18

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        
        addSubview(trainingLabel)
        trainingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
        
        addSubview(trainingButton)
        trainingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
    }
}
