//
//  TrainingViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//
//

import UIKit
import OrderedCollections
import SwipeCellKit

// MARK: Protocol - TrainingPresenterToViewProtocol (Presenter -> View)
protocol TrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setTrainingData(data: [TrainingCellViewModel])
    func setTrainingProgressKm(km: Float, kmLabel: String)
    func setTrainingProgressStep(step: Float, stepLabel: String)
}

// MARK: Protocol - TrainingRouterToViewProtocol (Router -> View)
protocol TrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class TrainingViewController: UIViewController, SwipeTableViewCellDelegate {
    // MARK: - Property
    var presenter: TrainingViewToPresenterProtocol!
    private var diffableDataSource: UITableViewDiffableDataSource<SectionTrainingModel, TrainingCellViewModel>?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.information
        label.font = OurFonts.fontPTSansBold32
        return label
    }()
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.activity
        label.font = OurFonts.fontPTSansBold20
        return label
    }()
    private let allActivityButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Training.allActivity, for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16

        return button
    }()
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.step
        label.font = OurFonts.fontPTSansBold20
        return label
    }()
    private let kilometresLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.kilomertes
        label.font = OurFonts.fontPTSansBold20
        return label
    }()
    private let progressBarStep = TrainingProgressStepView()

    private let progressBarKm = TrainingProgressKmView()
    private lazy var trainingDataTable: UITableView = {
        let table = UITableView()
        table.tintColor = PaletteApp.black
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        return table
    }()
    // MARK: - init
    override func viewWillAppear(_ animated: Bool) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.viewDidLoad()
    }
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
        trainingDataTable.delegate = self
        trainingDataTable.register(TrainingTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    // MARK: - private func
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        setupDiffableDataSource()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Tx.Training.information,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    private func setupDiffableDataSource() {
        logger.log("\(#fileID) -> \(#function)")
        diffableDataSource = UITableViewDiffableDataSource(tableView: trainingDataTable) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TrainingTableViewCell
            cell?.delegate = self
            cell?.configure(with: item)
            return cell
        }
        diffableDataSource?.defaultRowAnimation = .fade
    }
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        view.addSubview(activityLabel)
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(50)
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        view.addSubview(allActivityButton)
        allActivityButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(50)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        view.addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(allActivityButton).inset(50)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        view.addSubview(kilometresLabel)
        kilometresLabel.snp.makeConstraints { make in
            make.top.equalTo(allActivityButton).inset(160)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        view.addSubview(progressBarStep)
        progressBarStep.snp.makeConstraints { make in
            make.top.equalTo(stepLabel).offset(35)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        view.addSubview(progressBarKm)
        progressBarKm.snp.makeConstraints { make in
            make.top.equalTo(kilometresLabel).offset(35)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        view.addSubview(trainingDataTable)
        trainingDataTable.snp.makeConstraints { make in
            make.top.equalTo(progressBarKm.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}

// MARK: Extension - TrainingPresenterToViewProtocol
extension TrainingViewController: TrainingPresenterToViewProtocol {
    func setTrainingProgressStep(step: Float, stepLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressBarStep.updateProgress(step: step, stepLabel: stepLabel)
    }
    func setTrainingProgressKm(km: Float, kmLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressBarKm.updateProgress(km: km, kmLabel: kmLabel)
    }
    func setTrainingData(data: [TrainingCellViewModel]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<SectionTrainingModel, TrainingCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        diffableDataSource?.apply(snapshot)
    }
}

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        cell.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        if let cell = tableView.cellForRow(at: indexPath) {
            presenter.detailedTappedCell(indexPath)
            cell.selectionStyle = .none
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        logger.log("\(#fileID) -> \(#function)")
        let headerView = TrainingHeaderView()
        headerView.backgroundColor = PaletteApp.white
        headerView.delegate = self
        return headerView
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        logger.log("\(#fileID) -> \(#function)")
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: Tx.Training.delete) { [weak presenter] _, _, _ in
            presenter?.indexCell(indexPath)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
}

// MARK: Extension - TrainingRouterToViewProtocol
extension TrainingViewController: TrainingRouterToViewProtocol {
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

extension TrainingViewController: SenderListTrainingDelegate {
    func senderTappedButton() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.listButtonTapped()
    }
}

extension TrainingViewController {
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> SwipeOptions {
        logger.log("\(#fileID) -> \(#function)")
        var options = SwipeOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        return options
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        logger.log("\(#fileID) -> \(#function)")
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .default, title: .none) { [weak presenter] _, indexPath in
            presenter?.indexCell(indexPath)
        }
        deleteAction.backgroundColor = PaletteApp.white
        deleteAction.transitionDelegate = ScaleTransition.default
        deleteAction.image = ListImages.Training.trashCircle
        return [deleteAction]
    }
}
