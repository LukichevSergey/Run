//
//  ChartsPresenter.swift
//  Run
//
//  Created by Evgenii Kutasov on 02.01.2024.
//

import UIKit
import OrderedCollections

// MARK: Protocol - ChartsViewToPresenterProtocol (View -> Presenter)
protocol ChartsViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func tappedButtonMoverment(segmentIndex: Int, moverment: MovementDirection)
    func tappedXAxis(xAxis: Double)}

// MARK: Protocol - ChartsInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ChartsInteractorToPresenterProtocol: AnyObject {
    func dataChartsIsFetched(data: [ChartsDataPeriodViewModel], hiddenButton: IsHiddenButton)
    func dataSingleColumn(data: [ChartsDataPeriodViewModel.DataPeriod])
    func trainingIsFetchedWithError(error: Error)
}

final class ChartsPresenter {
    
    // MARK: Properties
    var router: ChartsPresenterToRouterProtocol!
    var interactor: ChartsPresenterToInteractorProtocol!
    weak var view: ChartsPresenterToViewProtocol!
}

// MARK: Extension - ChartsViewToPresenterProtocol
extension ChartsPresenter: ChartsViewToPresenterProtocol {
    func tappedXAxis(xAxis: Double) {
        logger.log("\(#fileID) -> \(#function)")
        interactor.getXAxisFromChatrs(xAxis: xAxis)
    }
    
    func tappedButtonMoverment(segmentIndex: Int, moverment: MovementDirection) {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTraining(segmentIndex: segmentIndex, movermentButton: moverment)
    }
    
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTraining(segmentIndex: 0, movermentButton: .empty)
    }
}

// MARK: Extension - ChartsInteractorToPresenterProtocol
extension ChartsPresenter: ChartsInteractorToPresenterProtocol {
    func dataSingleColumn(data: [ChartsDataPeriodViewModel.DataPeriod]) {
        logger.log("\(#fileID) -> \(#function)")
        guard let distance = data.first?.distance,
              let time = data.first?.time else {
            return
        }
        view.setDataInChartsSingleColumn(distance: "\(String(format: "%.2f", distance)) \(Tx.Timer.kilometr)",
                                         time: time.toHourAndMin())
    }
    
    func dataChartsIsFetched(data: [ChartsDataPeriodViewModel], hiddenButton: IsHiddenButton) {
        logger.log("\(#fileID) -> \(#function)")
        guard let dataCharts = data.first?.dataCharts,
              let date = data.first?.date else {
            return
        }
        guard let dataDistance = data.first?.dataTotal.reduce(0, { partialResult, distance in
            return partialResult + distance.distance
        }) else { return }
        guard let dataTime = data.first?.dataTotal.reduce(0, { partialResult, time in
            return partialResult + time.time
        }) else { return }
                
        view.setDataInCharts(dateWeek: "\(String(describing: date))",
                             dataCharts: dataCharts,
                             distance: "\(String(format: "%.2f", dataDistance)) \(Tx.Timer.kilometr)",
                             time: dataTime.toHourAndMin(), hiddenButton: hiddenButton)
        
        view.removeActivityIndicator()
    }
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
