//
//  ChartsInteractor.swift
//  Run
//
//  Created by Evgenii Kutasov on 02.01.2024.
//

import OrderedCollections
import DGCharts

// MARK: Protocol - ChartsPresenterToInteractorProtocol (Presenter -> Interactor)
protocol ChartsPresenterToInteractorProtocol: AnyObject {
    func fetchTraining(segmentIndex: Int, movermentButton: MovementDirection)
    func getXAxisFromChatrs(xAxis: Double)
}

final class ChartsInteractor {
    
    // MARK: Properties
    weak var presenter: ChartsInteractorToPresenterProtocol!
    private let dataBase: TrainingToDatabaseServiceProtocol
    private let chartManager = ChartsManager()
    private var _trainings = OrderedSet<Training>()
    private var _dataChartTotal = [ChartsDataPeriodViewModel.DataPeriod]()
    
    init() {
        dataBase = DatabaseService()
    }
}

// MARK: Extension - ChartsPresenterToInteractorProtocol
extension ChartsInteractor: ChartsPresenterToInteractorProtocol {
    func getXAxisFromChatrs(xAxis: Double) {
        logger.log("\(#fileID) -> \(#function)")
        let searchxAxis = chartManager.searchIndexXAxis(data: _dataChartTotal, xAxis: xAxis)
        presenter.dataSingleColumn(data: searchxAxis)
    }
    
    @MainActor
    func fetchTraining(segmentIndex: Int, movermentButton: MovementDirection) {
        logger.log("\(#fileID) -> \(#function)")
        Task {
            do {
                let trainings = try await dataBase.getTrainings(for: GlobalData.userModel.value?.getId() ?? "")
                _trainings = trainings
                _dataChartTotal.removeAll()
                guard let saveDateAndClick = chartManager.getPeriodAgo(indexPeriod: segmentIndex, buttonMovement: movermentButton) else { return }
                let isHiddenMovermentForwardAndBack = chartManager.isHiddenButton(data: trainings, indexPeriod: segmentIndex, date: saveDateAndClick)
                var dataChartsInPeriod: [ChartsDataPeriodViewModel]?
                
                switch segmentIndex {
                case 0:
                    dataChartsInPeriod = chartManager.getDataForChartsInWeek(data: trainings, indexPeriod: segmentIndex, date: saveDateAndClick)
                case 1:
                    dataChartsInPeriod = chartManager.getDataForChartsInMonth(data: trainings, indexPeriod: segmentIndex, date: saveDateAndClick)
                case 2:
                    dataChartsInPeriod = chartManager.getDataForChartsInYear(data: trainings, indexPeriod: segmentIndex, date: saveDateAndClick)
                default:
                    break
                }
                if let dataChartsInPeriod = dataChartsInPeriod {
                    presenter.dataChartsIsFetched(data: dataChartsInPeriod, hiddenButton: isHiddenMovermentForwardAndBack)
                    _dataChartTotal = dataChartsInPeriod.first?.dataTotal ?? []
                }
            } catch {
                presenter.trainingIsFetchedWithError(error: error)
            }
        }
    }
}
