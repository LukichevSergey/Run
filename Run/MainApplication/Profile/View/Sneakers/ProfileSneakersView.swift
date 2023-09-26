//
//  ProfileSneakersView.swift
//  Run
//
//  Created by Сергей Лукичев on 25.09.2023.
//

import UIKit
import OrderedCollections

protocol ProfileSneakersViewDelegate: AnyObject {
    func snakersIsSelected(with id: String)
}

final class ProfileSneakersView: UIView {
    
    weak var delegate: ProfileSneakersViewDelegate?
    
    enum Section: CaseIterable {
        case images
    }
    
    private var infiniteScrollingBehaviour: InfiniteScrollingBehaviour!
    private var dataSource = Array<Sneakers>()
    
    private var pagesCount: Int = 0 {
        didSet {
            pagesCounterLabel.text = "\(currentPage + 1)/\(pagesCount + 1)"
        }
    }
    
    private var currentPage: Int = 0 {
        didSet {
            pagesCounterLabel.text = "\(currentPage + 1)/\(pagesCount + 1)"
        }
    }
    
    private lazy var previousImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(ListImages.Profile.chevronLeft, for: .normal)
        button.addTarget(self, action: #selector(previousImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(ListImages.Profile.chevronRight, for: .normal)
        button.addTarget(self, action: #selector(nextImageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProfileSneakersCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSneakersCollectionViewCell.reuseIdentifier)
        return collection
    }()
    
    private lazy var pagesCounterLabel: UILabel = {
        let label = UILabel()
        label.font = OurFonts.fontPTSansRegular14
        label.textColor = PaletteApp.black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        backgroundColor = PaletteApp.white
        
        addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(previousImageButton)
        previousImageButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(88)
            make.left.equalToSuperview().inset(4)
            make.centerY.equalTo(collection)
        }
        
        addSubview(nextImageButton)
        nextImageButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(88)
            make.right.equalToSuperview().inset(4)
            make.centerY.equalTo(collection)
        }
        
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
        collection.addGestureRecognizer(tapOnImage)
    }
    
    private func configureScrollingBehaviour() {
        let configuration = CollectionViewConfiguration(layoutType: .fixedSize(sizeValue: UIScreen.main.bounds.width - 32, lineSpacing: 0), scrollingDirection: .horizontal)
        infiniteScrollingBehaviour = InfiniteScrollingBehaviour(withCollectionView: collection, andData: dataSource, delegate: self, configuration: configuration)
        
        if let selectedIndex = dataSource.firstIndex(where: {$0.isActive}), selectedIndex != 0 {
            infiniteScrollingBehaviour.scroll(toElementAtIndex: selectedIndex, animated: true)
        }
    }
    
    @objc private func previousImageButtonTapped() {
        infiniteScrollingBehaviour.scroll(toElementAtIndex: currentPage - 1, animated: true)
    }
    
    @objc private func nextImageButtonTapped() {
        infiniteScrollingBehaviour.scroll(toElementAtIndex: currentPage + 1, animated: true)
    }
    
    @objc private func tapOnImage() {
        logger.log("\(#fileID) -> \(#function)")
        delegate?.snakersIsSelected(with: dataSource[currentPage].id)
    }
}

extension ProfileSneakersView: ConfigurableViewProtocol {    
    func configure(with model: OrderedSet<Sneakers>) {
        logger.log("\(#fileID) -> \(#function)")
        pagesCount = model.count - 1
        dataSource = model.map({ $0 })
        
        nextImageButton.isHidden = model.count < 2
        previousImageButton.isHidden = model.count < 2
        collection.isScrollEnabled = model.count > 1
        
        configureScrollingBehaviour()
    }
}

extension ProfileSneakersView: InfiniteScrollingBehaviourDelegate {
    func configuredCell(forItemAtIndexPath indexPath: IndexPath, andData data: InfiniteScollingData) -> UICollectionViewCell {
        guard let cellData = data as? Sneakers,
            let cell = collection.dequeueReusableCell(withReuseIdentifier: ProfileSneakersCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileSneakersCollectionViewCell
        else
            { return UICollectionViewCell() }
        cell.configure(with: cellData)
        cell.layer.cornerRadius = 16
        return cell
    }
    
    func currentPageDidUpdated(to newPage: Int) {
        currentPage = newPage
    }
}

extension Sneakers: InfiniteScollingData { }
