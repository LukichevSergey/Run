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
    func tappedButtonMoverment(segmentIndex: Int, moverment: String)
    func tappedXAxis(xAxis: Double)}

// MARK: Protocol - ChartsInteractorToPresenterProtocol (Interactor -> Presenter)
protocol ChartsInteractorToPresenterProtocol: AnyObject {
    func dataChartsIsFetched(data: [ChartsDataPeriodViewModel], hiddenButton: Int)
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
        interactor.getXAxisFromChatrs(xAxis: xAxis)
    }
    
    func tappedButtonMoverment(segmentIndex: Int, moverment: String) {
        view.showActivityIndicator()
        interactor.fetchTraining(segmentIndex: segmentIndex, movermentButton: moverment)
    }
    
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        view.showActivityIndicator()
        interactor.fetchTraining(segmentIndex: 0, movermentButton: "")
    }
}

// MARK: Extension - ChartsInteractorToPresenterProtocol
extension ChartsPresenter: ChartsInteractorToPresenterProtocol {
    func dataSingleColumn(data: [ChartsDataPeriodViewModel.DataPeriod]) {
        guard let distance = data.first?.distance,
              let time = data.first?.time,
              let kkal = data.first?.calories else {
            return
        }
        view.setDataInChartsSingleColumn(distance: "\(String(format: "%.2f", distance)) \(Tx.Timer.kilometr)",
                                         time: time.toHourAndMin(),
                                         kkal: kkal)
    }
    
    func dataChartsIsFetched(data: [ChartsDataPeriodViewModel], hiddenButton: Int) {
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
        guard let dataKkal = data.first?.dataTotal.reduce(0, { partialResult, kkal in
            return partialResult + kkal.calories
        }) else { return }
                
        view.setDataInCharts(dateWeek: "\(String(describing: date))",
                             dataCharts: dataCharts,
                             distance: "\(String(format: "%.2f", dataDistance)) \(Tx.Timer.kilometr)",
                             time: dataTime.toHourAndMin(),
                             kkal: dataKkal, hiddenButton: hiddenButton)
        
        view.removeActivityIndicator()
    }
    
    func trainingIsFetchedWithError(error: Error) {
        logger.log("\(#fileID) -> \(#function)")
        view.removeActivityIndicator()
    }
}
