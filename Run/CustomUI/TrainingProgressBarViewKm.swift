//
//  TrainingProgressBar.swift
//  Run
//
//  Created by Evgenii Kutasov on 19.10.2023.
//

import Foundation
import UIKit

protocol ProgressBarViewProtocol: AnyObject {
    func updateProgress(km: Float, kmLabel: String)
}

class TrainingProgressBarViewKm: UIView {
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.backgroundColor = .white
        progress.tintColor = PaletteApp.lightblue
        progress.layer.cornerRadius = 15
        progress.layer.borderColor = PaletteApp.darkblue.cgColor
        progress.layer.borderWidth = 2
        
        progress.clipsToBounds = true

        return progress
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold16
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        logger.log("\(#fileID) -> \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        progressView.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension TrainingProgressBarViewKm: ProgressBarViewProtocol {
    func updateProgress(km: Float, kmLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressView.setProgress(km, animated: false)
        resultLabel.text = kmLabel
    }
}

