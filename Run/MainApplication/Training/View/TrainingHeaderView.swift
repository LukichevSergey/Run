//
//  TrainingHeaderView.swift
//  Run
//
//  Created by Evgenii Kutasov on 25.10.2023.
//

import UIKit

protocol SenderListTrainingDelegate: AnyObject {
    func senderTappedButton()
}

final class TrainingHeaderView: UIView {
    weak var delegate: SenderListTrainingDelegate?
    private let trainingLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.title
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20

        return label
    }()

    private lazy var trainingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Training.allTraining, for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16
        button.addTarget(self, action: #selector(pushInAllTraining), for: .touchUpInside)

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
    @objc private func pushInAllTraining(_ sender: UIButton) {
        logger.log("\(#fileID) -> \(#function)")
        delegate?.senderTappedButton()
    }
}
