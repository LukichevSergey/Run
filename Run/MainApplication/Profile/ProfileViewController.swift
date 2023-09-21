//
//  ProfileViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit

// MARK: Protocol - ProfilePresenterToViewProtocol (Presenter -> View)
protocol ProfilePresenterToViewProtocol: AnyObject {
    func setUsername(on name: String)
    func setBalance(balance: Double)
    func setData(_ data: ProfileViewModel)
    
    func showActivityIndicator()
    func removeActivityIndicator()
}

// MARK: Protocol - ProfileRouterToViewProtocol (Router -> View)
protocol ProfileRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class ProfileViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    // MARK: - Property
    var presenter: ProfileViewToPresenterProtocol!
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20
        label.textAlignment = .right
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var topHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, balanceLabel])
        stack.axis = .horizontal
        
        return stack
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = .clear
        tableView.backgroundColor = PaletteApp.white

        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, ProfileTableViewCellViewModel>(tableView: tableView) { [weak self] tableView, indexPath, item in
        
        guard let self,
              let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell
        else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.addSubview(topHStack)
        topHStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

// MARK: Extension - ProfilePresenterToViewProtocol 
extension ProfileViewController: ProfilePresenterToViewProtocol{
    func setData(_ data: ProfileViewModel) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProfileTableViewCellViewModel>()
        
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data.cells, toSection: Section.main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setUsername(on name: String) {
        logger.log("\(#fileID) -> \(#function)")
        nameLabel.text = name
    }
    
    func setBalance(balance: Double) {
        logger.log("\(#fileID) -> \(#function)")
        balanceLabel.text = Tx.Profile.getBalance(balance: balance)
    }
}

// MARK: Extension - ProfileRouterToViewProtocol
extension ProfileViewController: ProfileRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: Extension - ProfileTableViewCellDelegate
extension ProfileViewController: ProfileTableViewCellDelegate {
    func tableViewCellTapped(with type: ProfileTableViewCellViewModel.CellType) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.tableViewCellTapped(with: type)
    }
}
