//
//  ListTrainingViewController.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import UIKit
import SwipeCellKit

// MARK: Protocol - ListTrainingPresenterToViewProtocol (Presenter -> View)
protocol ListTrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setListTrainingData(data: [SectionListTrainingModel])
}

// MARK: Protocol - ListTrainingRouterToViewProtocol (Router -> View)
protocol ListTrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class ListTrainingViewController: UIViewController, SwipeCollectionViewCellDelegate {
    // MARK: - Property
    var presenter: ListTrainingViewToPresenterProtocol!
    private var diffableCollectionDataSource: UICollectionViewDiffableDataSource<SectionListTrainingModel,
                                                                                 TrainingCellViewModel>?
    private let collectionViewTraining: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Tx.Training.title
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        return label
    }()
    private lazy var graphicsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Training.graphics, for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansRegular20
        button.addTarget(self, action: #selector(senderTappedButton), for: .touchUpInside)
        return button
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
        collectionViewTraining.delegate = self
        collectionViewTraining.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionViewTraining.register(ListHeaderCollectionView.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: "header")

    }
    // MARK: - private func
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        setupDiffableDataSource()
        setupHeaderCollection()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Tx.Training.title,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    @objc private func senderTappedButton() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.chartsTappedButton()
    }
    private func setupDiffableDataSource() {
        logger.log("\(#fileID) -> \(#function)")
        diffableCollectionDataSource = UICollectionViewDiffableDataSource<SectionListTrainingModel,
            TrainingCellViewModel>(collectionView: collectionViewTraining) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as? ListCollectionViewCell
            cell?.delegate = self
            cell?.configure(with: item)
            return cell
        }
    }
    private func setupHeaderCollection() {
        logger.log("\(#fileID) -> \(#function)")
        diffableCollectionDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let section = self.diffableCollectionDataSource?.sectionIdentifier(for: indexPath.section) else {
                return UICollectionViewCell()
            }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "header",
                                                                         for: indexPath) as? ListHeaderCollectionView
            header?.configure(with: section)
            return header
        }
    }
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.left.equalToSuperview().inset(20)
        }
        view.addSubview(graphicsButton)
        graphicsButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(30)
        }
        view.addSubview(collectionViewTraining)
        collectionViewTraining.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.bottom.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}

// MARK: Extension - ListTrainingPresenterToViewProtocol
extension ListTrainingViewController: ListTrainingPresenterToViewProtocol {
    func setListTrainingData(data: [SectionListTrainingModel]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<SectionListTrainingModel, TrainingCellViewModel>()
        for section in data {
            snapshot.appendSections([section])
            snapshot.appendItems(section.training, toSection: section)
        }
        diffableCollectionDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: Extension - ListTrainingRouterToViewProtocol
extension ListTrainingViewController: ListTrainingRouterToViewProtocol {
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }
    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

extension ListTrainingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        logger.log("\(#fileID) -> \(#function)")
        return CGSize(width: collectionView.bounds.width, height: 95)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        logger.log("\(#fileID) -> \(#function)")
        return CGSize(width: (view.frame.width) - 30, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        logger.log("\(#fileID) -> \(#function)")

        return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.detailedTappedCell(indexPath)
    }
}

extension ListTrainingViewController {
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath,
                        for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        return options
    }
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath,
                        for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
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
