//
//  ChartsDataViewModel.swift
//  Run
//
//  Created by Evgenii Kutasov on 07.01.2024.
//

import DGCharts

struct ChartsDataPeriodViewModel {
    let date: String
    let dataCharts: [BarChartDataEntry]
    let dataTotal: [DataPeriod]
}

extension ChartsDataPeriodViewModel {
    struct DataPeriod {
        var date: Double
        var distance: Double
        var time: Double
    }
}
