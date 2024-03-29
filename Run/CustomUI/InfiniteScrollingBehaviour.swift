//
//  InfiniteScrollingBehaviour.swift
//  Run
//
//  Created by Сергей Лукичев on 26.09.2023.
//

import UIKit

public protocol InfiniteScrollingBehaviourDelegate: AnyObject {
    func configuredCell(forItemAtIndexPath indexPath: IndexPath,
                        andData data: InfiniteScollingData) -> UICollectionViewCell
    func didSelectItem(atIndexPath indexPath: IndexPath, originalIndex: Int,
                       andData data: InfiniteScollingData,
                       inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour)
    func didEndScrolling(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour)
    func didEndAnimation(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour)
    func verticalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: InfiniteScrollingBehaviour) -> CGFloat
    func horizonalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: InfiniteScrollingBehaviour) -> CGFloat
    func currentPageDidUpdated(to newPage: Int)
}

public extension InfiniteScrollingBehaviourDelegate {
    func didSelectItem(atIndexPath indexPath: IndexPath, originalIndex: Int,
                       andData data: InfiniteScollingData,
                       inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) { }
    func didEndScrolling(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) { }
    func didEndAnimation(inInfiniteScrollingBehaviour behaviour: InfiniteScrollingBehaviour) { }
    func verticalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: InfiniteScrollingBehaviour) -> CGFloat {
        return 0
    }
    func horizonalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: InfiniteScrollingBehaviour) -> CGFloat {
        return 0
    }
    func currentPageDidUpdated(to newPage: Int) { }
}

public protocol InfiniteScollingData { }

public enum LayoutType {
    case fixedSize(sizeValue: CGFloat, lineSpacing: CGFloat)
    case numberOfCellOnScreen(Double)
}

public struct CollectionViewConfiguration {
    public let scrollingDirection: UICollectionView.ScrollDirection
    public var layoutType: LayoutType
    public static let `default` = CollectionViewConfiguration(layoutType: .numberOfCellOnScreen(5),
                                                              scrollingDirection: .horizontal)
    public init(layoutType: LayoutType, scrollingDirection: UICollectionView.ScrollDirection) {
        self.layoutType = layoutType
        self.scrollingDirection = scrollingDirection
    }
}

public class InfiniteScrollingBehaviour: NSObject {
    fileprivate var cellSize: CGFloat = 0.0
    fileprivate var padding: CGFloat = 0.0
    fileprivate var numberOfBoundaryElements = 0
    fileprivate(set) public weak var collectionView: UICollectionView!
    fileprivate(set) public weak var delegate: InfiniteScrollingBehaviourDelegate?
    fileprivate(set) public var dataSet: [InfiniteScollingData]
    fileprivate(set) public var dataSetWithBoundary: [InfiniteScollingData] = []
    fileprivate var collectionViewBoundsValue: CGFloat {
            switch collectionConfiguration.scrollingDirection {
            case .horizontal:
                return collectionView.bounds.size.width
            case .vertical:
                return collectionView.bounds.size.height
            @unknown default:
                return collectionView.bounds.size.width
            }
    }
    fileprivate var scrollViewContentSizeValue: CGFloat {
            switch collectionConfiguration.scrollingDirection {
            case .horizontal:
                return collectionView.contentSize.width
            case .vertical:
                return collectionView.contentSize.height
            @unknown default:
                return collectionView.contentSize.width
            }
    }
    fileprivate(set) public var collectionConfiguration: CollectionViewConfiguration
    public init(withCollectionView collectionView: UICollectionView,
                andData dataSet: [InfiniteScollingData],
                delegate: InfiniteScrollingBehaviourDelegate,
                configuration: CollectionViewConfiguration = .default) {
        self.collectionView = collectionView
        self.dataSet = dataSet
        self.collectionConfiguration = configuration
        self.delegate = delegate
        super.init()
        configureBoundariesForInfiniteScroll()
        configureCollectionView()
        scrollToFirstElement()
    }
    private func configureBoundariesForInfiniteScroll() {
        dataSetWithBoundary = dataSet
        calculateCellWidth()
        let absoluteNumberOfElementsOnScreen = ceil(collectionViewBoundsValue/cellSize)
        numberOfBoundaryElements = Int(absoluteNumberOfElementsOnScreen)
        addLeadingBoundaryElements()
        addTrailingBoundaryElements()
    }
    private func calculateCellWidth() {
        switch collectionConfiguration.layoutType {
        case .fixedSize(let sizeValue, let padding):
            cellSize = sizeValue
            self.padding = padding
        case .numberOfCellOnScreen(let numberOfCellsOnScreen):
            cellSize = (collectionViewBoundsValue/numberOfCellsOnScreen.cgFloat)
            padding = 0
        }
    }
    private func addLeadingBoundaryElements() {
        for index in stride(from: numberOfBoundaryElements, to: 0, by: -1) {
            let indexToAdd = (dataSet.count - 1) - ((numberOfBoundaryElements - index)%dataSet.count)
            let data = dataSet[indexToAdd]
            dataSetWithBoundary.insert(data, at: 0)
        }
    }
    private func addTrailingBoundaryElements() {
        for index in 0..<numberOfBoundaryElements {
            let data = dataSet[index%dataSet.count]
            dataSetWithBoundary.append(data)
        }
    }
    private func configureCollectionView() {
        guard let delegate = self.delegate else { return }
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = collectionConfiguration.scrollingDirection
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func scrollToFirstElement() {
        scroll(toElementAtIndex: 0)
    }
    public func scroll(toElementAtIndex index: Int, animated: Bool = false) {
        let boundaryDataSetIndex = indexInBoundaryDataSet(forIndexInOriginalDataSet: index)
        let indexPath = IndexPath(item: boundaryDataSetIndex, section: 0)
        let scrollPosition: UICollectionView.ScrollPosition = collectionConfiguration.scrollingDirection ==
            .horizontal ? .left : .top
        collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    public func indexInOriginalDataSet(forIndexInBoundaryDataSet index: Int) -> Int {
        let difference = index - numberOfBoundaryElements
        if difference < 0 {
            let originalIndex = dataSet.count + difference
            return abs(originalIndex % dataSet.count)
        } else if difference < dataSet.count {
            return difference
        } else {
            return abs((difference - dataSet.count) % dataSet.count)
        }
    }
    public func indexInBoundaryDataSet(forIndexInOriginalDataSet index: Int) -> Int {
        return index + numberOfBoundaryElements
    }
    public func reload(withData dataSet: [InfiniteScollingData]) {
        self.dataSet = dataSet
        configureBoundariesForInfiniteScroll()
        collectionView.reloadData()
        scrollToFirstElement()
    }
    public func updateConfiguration(configuration: CollectionViewConfiguration) {
        collectionConfiguration = configuration
        configureBoundariesForInfiniteScroll()
        configureCollectionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.collectionView.reloadData()
            self.scrollToFirstElement()
        }
    }
}

extension InfiniteScrollingBehaviour: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        switch (collectionConfiguration.scrollingDirection, delegate) {
        case (.horizontal, .some(let delegate)):
            let inset = delegate.verticalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: self)
            return UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        case (.vertical, .some(let delegate)):
            let inset = delegate.horizonalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: self)
            return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        case (_, _):
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (collectionConfiguration.scrollingDirection, delegate) {
        case (.horizontal, .some(let delegate)):
            let height = collectionView.bounds.size.height - 2 *
            delegate.verticalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: self)
            return CGSize(width: cellSize, height: height)
        case (.vertical, .some(let delegate)):
            let width = collectionView.bounds.size.width - 2 *
            delegate.horizonalPaddingForHorizontalInfiniteScrollingBehaviour(behaviour: self)
            return CGSize(width: width, height: cellSize)
        case (.horizontal, _):
            return CGSize(width: cellSize, height: collectionView.bounds.size.height)
        case (.vertical, _):
            return CGSize(width: collectionView.bounds.size.width, height: cellSize)
        case (_, _):
            return CGSize(width: 0, height: 0)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let originalIndex = indexInOriginalDataSet(forIndexInBoundaryDataSet: indexPath.item)
        delegate?.didSelectItem(atIndexPath: indexPath, originalIndex: originalIndex,
                                andData: dataSetWithBoundary[indexPath.item],
                                inInfiniteScrollingBehaviour: self)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let boundarySize = numberOfBoundaryElements.cgFloat * cellSize +
        (numberOfBoundaryElements.cgFloat * padding)
        let contentOffsetValue = collectionConfiguration.scrollingDirection ==
            .horizontal ? scrollView.contentOffset.x : scrollView.contentOffset.y
        if contentOffsetValue >= (scrollViewContentSizeValue - boundarySize) {
            let offset = boundarySize - padding
            let updatedOffsetPoint = collectionConfiguration.scrollingDirection == .horizontal ?
                CGPoint(x: offset, y: 0) : CGPoint(x: 0, y: offset)
            scrollView.contentOffset = updatedOffsetPoint
        } else if contentOffsetValue <= 0 {
            let boundaryLessSize = dataSet.count.cgFloat * cellSize + (dataSet.count.cgFloat * padding)
            let updatedOffsetPoint = collectionConfiguration.scrollingDirection == .horizontal ?
                CGPoint(x: boundaryLessSize, y: 0) : CGPoint(x: 0, y: boundaryLessSize)
            scrollView.contentOffset = updatedOffsetPoint
        }
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        let currentBoundaryPage = Int(offSet + horizontalCenter) / Int(width)
        let currentPage = indexInOriginalDataSet(forIndexInBoundaryDataSet: currentBoundaryPage)
        delegate?.currentPageDidUpdated(to: currentPage)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.didEndScrolling(inInfiniteScrollingBehaviour: self)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            delegate?.didEndScrolling(inInfiniteScrollingBehaviour: self)
        }
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.didEndAnimation(inInfiniteScrollingBehaviour: self)
    }
}

extension InfiniteScrollingBehaviour: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSetWithBoundary.count
    }
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = self.delegate else {
            return UICollectionViewCell()
        }
        return delegate.configuredCell(forItemAtIndexPath: indexPath, andData: dataSetWithBoundary[indexPath.item])
    }
}
