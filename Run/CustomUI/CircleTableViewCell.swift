//
//  CircleTableViewCell.swift
//  Run
//
//  Created by Evgenii Kutasov on 03.09.2023.
//

import UIKit

final class CircleTableViewCell: UITableViewCell {
    
    
    private let circleLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.tintColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    
    private let distancseLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.tintColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.tintColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular20
        return label
    }()
    
    private func commonInit() {
        addSubview(circleLabel)
        // Располагаем circleLabel
        circleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
        }

        addSubview(distancseLabel)
        distancseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(circleLabel.snp.top)
            make.leading.equalTo(circleLabel.snp.trailing).offset(40) // Отступ справа от circleLabel
        }

        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(distancseLabel.snp.top)
            make.leading.equalTo(distancseLabel.snp.trailing).offset(40) // Отступ справа от distancseLabel
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CircleTableViewCell: ConfigurableViewProtocol {

    func configure(with model: CircleViewModel) {
        circleLabel.text = model.circle
        distancseLabel.text = model.distance
        timeLabel.text = model.time
    }
}
