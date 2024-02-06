//
//  ChartsManager.swift
//  Run
//
//  Created by Evgenii Kutasov on 07.01.2024.
//

import OrderedCollections
import DGCharts
import Foundation

final class ChartsManager {
    let calendar = Calendar.current
    var agoWeek = 0
    var agoMonth = 0
    var agoYear = 0
    func searchIndexXAxis(data: [ChartsDataPeriodViewModel.DataPeriod],
                          xAxis: Double) -> [ChartsDataPeriodViewModel.DataPeriod] {
        logger.log("\(#fileID) -> \(#function)")
        var dataXAxis = [ChartsDataPeriodViewModel.DataPeriod]()
        data.forEach { index in
            if index.date == xAxis {
                dataXAxis.append(ChartsDataPeriodViewModel.DataPeriod(date: index.date,
                                                                      distance: index.distance,
                                                                      time: index.time))
            }
        }
        return dataXAxis
    }
    /// Метод который получает дату для графиков за год
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет высчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInYear(data: OrderedSet<Training>, indexPeriod: Int,
                                date: Date) -> [ChartsDataPeriodViewModel] {
        logger.log("\(#fileID) -> \(#function)")
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstMonthOfYear()
        let endDay = date.lastMonthOfYear()
        let currentYear = date.formatDate("Y")
        while firstDay < endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("M")) ?? 0, y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("M")) ?? 0,
                                                                         distance: 0,
                                                                         time: 0))
            data.forEach { training in
                if training.startTime.formatDate("M") == "\(firstDay.formatDate("M"))" &&
                    training.startTime.formatDate("Y") == "\(currentYear)" {
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x ==
                        Double(firstDay.formatDate("M")) }) {
                        dataForCharts[existingValue].y += training.distance
                        dataForTotalWeek[existingValue].distance += training.distance
                        dataForTotalWeek[existingValue].time += training.time
                    }
                }
            }
            if let nextDate = Calendar.current.date(byAdding: DateComponents(month: 1), to: firstDay) {
                firstDay = nextDate
            }
        }
        dataChartsPeriod.append(ChartsDataPeriodViewModel(date: "\(date.formatDate("yyyy").capitalized)",
                                               dataCharts: dataForCharts,
                                               dataTotal: dataForTotalWeek))
        return dataChartsPeriod
    }
    /// Метод который получает дату для графиков за Месяц
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет высчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInMonth(data: OrderedSet<Training>,
                                 indexPeriod: Int,
                                 date: Date) -> [ChartsDataPeriodViewModel] {
        logger.log("\(#fileID) -> \(#function)")
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstDayOfMonth()
        let endDay = date.lastDayOfMonth()
        let currentMonth = date.formatDate("M")
        while firstDay <= endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("d")) ?? 0, y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("d")) ?? 0,
                                                                         distance: 0,
                                                                         time: 0))
            data.forEach { training in
                if training.startTime.formatDate("d") == "\(firstDay.formatDate("d"))" &&
                    training.startTime.formatDate("M") == "\(currentMonth)" {
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x ==
                        Double(firstDay.formatDate("d")) }) {
                        dataForCharts[existingValue].y += training.distance
                        dataForTotalWeek[existingValue].distance += training.distance
                        dataForTotalWeek[existingValue].time += training.time
                    }
                }
            }
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: firstDay) {
                firstDay = nextDate
            }
        }
        dataChartsPeriod.append(ChartsDataPeriodViewModel(date: "\(date.formatDate("MMM yyyy").capitalized)",
                                               dataCharts: dataForCharts,
                                               dataTotal: dataForTotalWeek))
        return dataChartsPeriod
    }
    /// Метод который получает дату для графиков за неделю
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет рассчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInWeek(data: OrderedSet<Training>,
                                indexPeriod: Int,
                                date: Date) -> [ChartsDataPeriodViewModel] {
        logger.log("\(#fileID) -> \(#function)")
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstOfWeek()
        let endDay = date.lastOfWeek()
        let currentMonth = date.formatDate("M")
        while firstDay <= endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("d")) ?? 0, y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("d")) ?? 0,
                                                                         distance: 0,
                                                                         time: 0))
            data.forEach { training in
                if training.startTime.formatDate("d") == "\(firstDay.formatDate("d"))" &&
                    training.startTime.formatDate("M") == "\(currentMonth)" {
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x ==
                        Double(firstDay.formatDate("d")) }) {
                        dataForCharts[existingValue].y += training.distance
                        dataForTotalWeek[existingValue].distance += training.distance
                        dataForTotalWeek[existingValue].time += training.time
                    }
                }
            }
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: firstDay) {
                firstDay = nextDate
            }
        }
        firstDay = date.firstOfWeek()
        dataChartsPeriod.append(ChartsDataPeriodViewModel(date:
                "\(firstDay.formatDate("d")) - \(endDay.formatDate("d")) \(date.formatDate("MMM yyyy").capitalized)",
                dataCharts: dataForCharts,
                dataTotal: dataForTotalWeek))
        return dataChartsPeriod
    }
    /// Метод выполняет сохранение периода движения и возвращает дату от которой начнется рассчет
    /// - Parameters:
    ///   - indexPerion: индекс периода в сегмент контроле
    ///   - buttonMovement: Кнопка движения на которую кликнули врепед или назад
    /// - Returns: Возвразает дату с которой начнется весь рассчет
    func getPeriodAgo(indexPeriod: Int, buttonMovement: MovementDirection) -> Date? {
        logger.log("\(#fileID) -> \(#function)")
        if let period = PeriodofTime(rawValue: indexPeriod) {
            switch period {
            case .week:
                agoWeek += buttonMovement == .back ? 7 : 0
                agoWeek += buttonMovement == .forward ? -7 : 0
                let targetedWeekDate = Calendar.current.date(byAdding: .day, value: -agoWeek, to: Date())
                return targetedWeekDate
            case .month:
                agoMonth += buttonMovement == .back ? 1 : 0
                agoMonth += buttonMovement == .forward ? -1 : 0
                let targetedMonth = Calendar.current.date(byAdding: .month, value: -agoMonth, to: Date())
                return targetedMonth
            case .year:
                agoYear += buttonMovement == .back ? 1 : 0
                agoYear += buttonMovement == .forward ? -1 : 0
                let targetedYear = Calendar.current.date(byAdding: .year, value: -agoYear, to: Date())
                return targetedYear
            }
        }
        return Date()
    }
    /// Метод определяет когда было достигнуто начало или конец даты чтобы скрыть кнопки
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod:  индекс периода в сегмент контроле
    ///   - date: Дата с которой все будет рассчитываться
    /// - Returns: Возвращает цифру для того чтобы понять нужно скрывать кнопку или нет
    func isHiddenButton(data: OrderedSet<Training>, indexPeriod: Int, date: Date) -> IsHiddenButton {
        logger.log("\(#fileID) -> \(#function)")
        let sortDate = data.sorted { $0.startTime < $1.startTime }
        let firstDate = sortDate.first?.startTime
        let lastDate = sortDate.last?.startTime
        if let period = PeriodofTime(rawValue: indexPeriod) {
            switch period {
            case .week:
                if firstDate?.firstOfWeek() == date.firstOfWeek() {
                    return .isHiddenButtonBack
                } else if lastDate?.firstOfWeek() == date.firstOfWeek() {
                    return .isHiddenButtonForward
                } else if date.firstOfWeek() == Date().firstOfWeek() {
                    return .isHiddenButtonForward
                }
            case .month:
                if firstDate?.firstDayOfMonth() == date.firstDayOfMonth() {
                    return .isHiddenButtonBack
                } else if lastDate?.firstDayOfMonth() == date.firstDayOfMonth() {
                    return .isHiddenButtonForward
                } else if date.firstDayOfMonth() == Date().firstDayOfMonth() {
                    return .isHiddenButtonForward
                }
            case .year:
                if firstDate?.firstMonthOfYear() == date.firstMonthOfYear() {
                    return .isHiddenButtonBack
                } else if lastDate?.firstMonthOfYear() == date.firstMonthOfYear() {
                    return .isHiddenButtonForward
                } else if date.firstMonthOfYear() == Date().firstMonthOfYear() {
                    return .isHiddenButtonForward
                }
            }
        }
        return .notHiddenButton
    }
}
