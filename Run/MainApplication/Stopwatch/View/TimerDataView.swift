//
//  TimerDataView.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//

import UIKit

final class TimerDataView: UIView {
    private lazy var kilometrView: TimerStatsLabel = {
        let view = TimerStatsLabel()
        return view
    }()
    private lazy var tempView: TimerStatsLabel = {
        let view = TimerStatsLabel()
        return view
    }()
    private lazy var averageTempView: TimerStatsLabel = {
        let view = TimerStatsLabel()
        return view
    }()
    private lazy var dataHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [kilometrView, tempView, averageTempView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing

        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        addSubview(dataHStack)
        dataHStack.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}

extension TimerDataView: ConfigurableViewProtocol {
    func configure(with model: TimerViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        kilometrView.configure(with: model.kilometrModel)
        tempView.configure(with: model.tempModel)
        averageTempView.configure(with: model.averageTempModel)
    }
    typealias ConfigurationModel = TimerViewModel
}
