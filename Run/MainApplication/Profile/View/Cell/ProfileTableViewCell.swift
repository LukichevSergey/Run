//
//  ProfileTableViewCell.swift
//  Run
//
//  Created by Лукичев Сергей on 03.09.2023.
//

import UIKit

protocol ProfileTableViewCellDelegate: AnyObject {
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType)
}

final class ProfileTableViewCell: UITableViewCell {
    
    weak var delegate: ProfileTableViewCellDelegate?
    
    static let reuseIdentifier = String(describing: ProfileTableViewCell.self)
    
    private var type: ProfileTableViewCellViewModel.CellType?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        contentView.backgroundColor = PaletteApp.white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(16)
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
}

extension ProfileTableViewCell: ConfigurableViewProtocol {
    func configure(with model: ProfileTableViewCellViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        type = model.type
        titleLabel.text = model.type.cellTitle
    }
    
    typealias ConfigurationModel = ProfileTableViewCellViewModel
}

private extension ProfileTableViewCell {
    @objc private func cellTapped() {
        logger.log("\(#fileID) -> \(#function)")
        guard let type else { return }
        delegate?.tableViewCellTapped(with: type)
    }
}
