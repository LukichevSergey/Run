//
//  DetailedTrainingViewController.swift
//  Run
//
//  Created by Evgenii Kutasov on 21.11.2023.
//

import UIKit

// MARK: Protocol - DetailedTrainingPresenterToViewProtocol (Presenter -> View)
protocol DetailedTrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setDetailedTrainingData(data: [EnumDetailedViewCell])
    func setDateDetailedHeaderTraining(_ data: String)
}

// MARK: Protocol - DetailedTrainingRouterToViewProtocol (Router -> View)
protocol DetailedTrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class DetailedTrainingViewController: UIViewController {
    // MARK: - Property
    var presenter: DetailedTrainingViewToPresenterProtocol!
    private var diffableDataSourse: UITableViewDiffableDataSource<SectionTrainingModel, EnumDetailedViewCell>?
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    private var detailedTitleDateTraining: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        return label
    }()
    private let tableViewDetailed: UITableView = {
        let table = UITableView()
        table.tintColor = PaletteApp.black
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        return table
    }()
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
        configureUI()
        presenter.viewDidLoad()
        tableViewDetailed.delegate = self
        tableViewDetailed.register(DetailedInfoTableViewCell.self, forCellReuseIdentifier: "cellInfo")
        tableViewDetailed.register(DetailedResultTableViewCell.self, forCellReuseIdentifier: "cellResult")
        tableViewDetailed.register(DetailedEveryKilometrTableViewCell.self, forCellReuseIdentifier: "cellEveryKM")
    }
    // MARK: - private func
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        setupDiffableDataSource()
    }
    func setupDiffableDataSource() {
        logger.log("\(#fileID) -> \(#function)")
        diffableDataSourse = UITableViewDiffableDataSource(tableView: tableViewDetailed) { tableView, indexPath, item in
            switch item {
            case .detailedInfo(let detailInfo):
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo",
                                                         for: indexPath) as? DetailedInfoTableViewCell
                cell?.configure(with: detailInfo)
                return cell
            case .detailedResult(let detailResult):
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellResult",
                                                         for: indexPath) as? DetailedResultTableViewCell
                cell?.configure(with: detailResult)
                return cell
            case .detailedEveryKilometer(let detailEveryKM):
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellEveryKM",
                                                         for: indexPath) as? DetailedEveryKilometrTableViewCell
                cell?.configure(with: detailEveryKM)
                return cell
            default: break
            }
            return UITableViewCell()
        }
        diffableDataSourse?.defaultRowAnimation = .fade
    }

    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white

        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        view.addSubview(detailedTitleDateTraining)
        detailedTitleDateTraining.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(50)
        }
        view.addSubview(tableViewDetailed)
        tableViewDetailed.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
    }
}

// MARK: Extension - DetailedTrainingPresenterToViewProtocol
extension DetailedTrainingViewController: DetailedTrainingPresenterToViewProtocol {
    func setDateDetailedHeaderTraining(_ data: String) {
        DispatchQueue.main.async { [weak self] in
            self?.detailedTitleDateTraining.text = data
        }
    }
    func setDetailedTrainingData(data: [EnumDetailedViewCell]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<SectionTrainingModel, EnumDetailedViewCell>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        diffableDataSourse?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: Extension - DetailedTrainingRouterToViewProtocol
extension DetailedTrainingViewController: DetailedTrainingRouterToViewProtocol {
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }
    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

extension DetailedTrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        cell.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectionStyle = .none
        }
    }
}
