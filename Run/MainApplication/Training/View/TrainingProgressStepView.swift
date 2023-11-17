//
//  TrainingProgressStepView.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import UIKit

protocol ProgressBarViewStepProtocol: AnyObject {
    func updateProgress(step: Float, stepLabel: String)
}

final class TrainingProgressStepView: UIView {

    private let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.backgroundColor = .white
        progress.tintColor = PaletteApp.lightOrange
        progress.layer.cornerRadius = 15
        progress.layer.borderColor = PaletteApp.darkbOrange.cgColor
        progress.layer.borderWidth = 2
        progress.clipsToBounds = true

        return progress
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold16

        return label
    }()

    override init(frame: CGRect) {
        logger.log("\(#fileID) -> \(#function)")
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        progressView.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension TrainingProgressStepView: ProgressBarViewStepProtocol {
    func updateProgress(step: Float, stepLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressView.setProgress(step, animated: false)
        resultLabel.text = stepLabel
    }
}
