//
//  DetailTrainingViewController.swift
//  Run
//
//  Created by Evgenii Kutasov on 30.10.2023.
//

import UIKit

// MARK: Protocol - DetailTrainingPresenterToViewProtocol (Presenter -> View)
protocol DetailTrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setDetailTrainingData(data: [TrainingCellViewModel])
}

// MARK: Protocol - DetailTrainingRouterToViewProtocol (Router -> View)
protocol DetailTrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class DetailTrainingViewController: UIViewController {
    
    // MARK: - Property
    var presenter: DetailTrainingViewToPresenterProtocol!
    
    private var diffableCollectionDataSource: UICollectionViewDiffableDataSource<SectionModelView, TrainingCellViewModel>?

    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        return stack
    }()
    
    private var collectionViewTraining: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.showsVerticalScrollIndicator = false
        
        return collection
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
        view.backgroundColor = PaletteApp.darkbOrange
        configureUI()
        presenter.viewDidLoad()
        collectionViewTraining.delegate = self
        collectionViewTraining.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

    }
    
    
    
    // MARK: - private func
    private func commonInit() {
        setupDiffableDataSource()
    }
    
    func setupDiffableDataSource(){
        logger.log("\(#fileID) -> \(#function)")
        diffableCollectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionViewTraining) { collectionView, indexPath, item in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DetailCollectionViewCell
            
            let viewModel = TrainingCellViewModel(killometrs: item.killometrs, image: item.image, data: item.data, title: item.title)
            cell?.configure(with: viewModel)
            
            return cell
        }
        collectionViewTraining.dataSource = diffableCollectionDataSource
    }
    
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white

        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        view.addSubview(collectionViewTraining)
        collectionViewTraining.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.bottom.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
    }
}

// MARK: Extension - DetailTrainingPresenterToViewProtocol
extension DetailTrainingViewController: DetailTrainingPresenterToViewProtocol {
    func setDetailTrainingData(data: [TrainingCellViewModel]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<SectionModelView, TrainingCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        diffableCollectionDataSource?.apply(snapshot)
    }
}

// MARK: Extension - TrainingRouterToViewProtocol
extension DetailTrainingViewController: DetailTrainingRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }

}

extension DetailTrainingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = PaletteApp.lightGreen
        cell.layer.borderWidth = 2
        cell.layer.borderColor = PaletteApp.darkblue.cgColor
        cell.layer.cornerRadius = 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (view.frame.width) - 30, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

    return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
}