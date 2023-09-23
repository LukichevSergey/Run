//
//  headerCircleTableView.swift
//  Run
//
//  Created by Evgenii Kutasov on 08.09.2023.
//

import UIKit

class HeaderCircleTableView: UIView {
    
    private let circleLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.CircleTableResult.circle
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.CircleTableResult.distance
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
    }()
    
    private let timeLbel: UILabel = {
        let label = UILabel()
        label.text = Tx.CircleTableResult.time
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20

        return label
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
        addSubview(circleLabel)
        circleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.verticalEdges.equalToSuperview()
        }
        
        addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleLabel.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview()
        }
        addSubview(timeLbel)
        timeLbel.snp.makeConstraints { make in
            make.leading.equalTo(distanceLabel.snp.trailing).offset(16)
            make.verticalEdges.equalToSuperview()
        }
    }
}
