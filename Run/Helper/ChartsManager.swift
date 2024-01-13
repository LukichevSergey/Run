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
    
    func searchIndexXAxis(data: [ChartsDataPeriodViewModel.DataPeriod], xAxis: Double) -> [ChartsDataPeriodViewModel.DataPeriod]  {
        var dataXAxis = [ChartsDataPeriodViewModel.DataPeriod]()
        data.forEach { index in
            if index.date == xAxis {
                dataXAxis.append(ChartsDataPeriodViewModel.DataPeriod(date: index.date, distance: index.distance, time: index.time, calories: index.calories))
            }
        }
        
        return dataXAxis
    }
    
    /// Метод который получает дату для графиков на год
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет высчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInYear(data: OrderedSet<Training>, indexPeriod: Int, date: Date) -> [ChartsDataPeriodViewModel] {
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstMonthOfYear()
        let endDay = date.lastMonthOfYear()
        let currentYear = date.formatDate("Y")
        
        while firstDay < endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("M")) ?? 0 , y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("M")) ?? 0, distance: 0,
                                                 time: 0,
                                                 calories: 0))
            data.forEach { training in
                if training.startTime.formatDate("M") == "\(firstDay.formatDate("M"))" && training.startTime.formatDate("Y") == "\(currentYear)" {
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x == Double(firstDay.formatDate("M")) }) {
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
    
    /// Метод который получает дату для графиков на Месяц
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет высчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInMonth(data: OrderedSet<Training>, indexPeriod: Int, date: Date) -> [ChartsDataPeriodViewModel] {
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstDayOfMonth()
        let endDay = date.lastDayOfMonth()
        let currentMonth = date.formatDate("M")
        
        while firstDay <= endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("d")) ?? 0, y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("d")) ?? 0, distance: 0,
                                                 time: 0,
                                                 calories: 0))
            data.forEach { training in
                if training.startTime.formatDate("d") == "\(firstDay.formatDate("d"))" && training.startTime.formatDate("M") == "\(currentMonth)" {
   
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x == Double(firstDay.formatDate("d")) }) {
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
    
    /// Метод который получает дату для графиков на Неделя
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPeriod: Индекс это выбранный период в сегменте контроле
    ///   - date: Дата с которой все будет рассчитываться
    /// - Returns: Возвращает массив с моделью ChartsDataPeriodViewModel
    func getDataForChartsInWeek(data: OrderedSet<Training>, indexPeriod: Int, date: Date) -> [ChartsDataPeriodViewModel] {
        var dataChartsPeriod = [ChartsDataPeriodViewModel]()
        var dataForCharts = [BarChartDataEntry]()
        var dataForTotalWeek = [ChartsDataPeriodViewModel.DataPeriod]()
        var firstDay = date.firstOfWeek()
        let endDay = date.lastOfWeek()
        let currentMonth = date.formatDate("M")
        
        while firstDay <= endDay {
            dataForCharts.append(BarChartDataEntry(x: Double(firstDay.formatDate("d")) ?? 0, y: 0))
            dataForTotalWeek.append(ChartsDataPeriodViewModel.DataPeriod(date: Double(firstDay.formatDate("d")) ?? 0, distance: 0,
                                                 time: 0,
                                                 calories: 10000))
            data.forEach { training in
                if training.startTime.formatDate("d") == "\(firstDay.formatDate("d"))" && training.startTime.formatDate("M") == "\(currentMonth)" {
                    
                    if let existingValue = dataForCharts.firstIndex(where: { $0.x == Double(firstDay.formatDate("d")) }) {
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
        dataChartsPeriod.append(ChartsDataPeriodViewModel(date: "\(firstDay.formatDate("d")) - \(endDay.formatDate("d")) \(date.formatDate("MMM yyyy").capitalized)",
                                               dataCharts: dataForCharts,
                                               dataTotal: dataForTotalWeek))
        
        return dataChartsPeriod
    }
    
    /// Метод выполняет сохранение периода движения и возвращает дату от которой начнется рассчет
    /// - Parameters:
    ///   - indexPerion: индекс периода в сегмент контроле
    ///   - buttonMovement: Кнопка движения на которую кликнули врепед или назад
    /// - Returns: Возвразает дату с которой начнется весь рассчет
    func getPedionAgo(indexPerion: Int, buttonMovement: String) -> Date? {
        switch indexPerion {
        case 0:
            if buttonMovement == "back" {
                agoWeek += 7
            } else if buttonMovement == "forward" {
                agoWeek -= 7
            }
            let targetedWeekDate = Calendar.current.date(byAdding: .day, value: -agoWeek, to: Date())

            return targetedWeekDate
        case 1:
            if buttonMovement == "back" {
                agoMonth += 1
            } else if buttonMovement == "forward" {
                agoMonth -= 1
            }
            let targetedMonth = Calendar.current.date(byAdding: .month, value: -agoMonth, to: Date())

            return targetedMonth
        case 2:
            if buttonMovement == "back" {
                agoYear += 1
            } else if buttonMovement == "forward" {
                agoYear -= 1
            }
            let targetedYear = Calendar.current.date(byAdding: .year, value: -agoYear, to: Date())

            return targetedYear
        default:
            
            return Date()
        }
    }
    
    /// Метод определяет когда было достигнуто начало или конец даты чтобы скрыть кнопки
    /// - Parameters:
    ///   - data: Данные с тренировками
    ///   - indexPediod:  индекс периода в сегмент контроле
    ///   - date: Дата с которой все будет рассчитываться
    /// - Returns: Возвращает цифру для того чтобы понять нужно скрывать кнопку или нет
    func isHiddenButton(data: OrderedSet<Training>, indexPediod: Int, date: Date) -> Int {
        let sortDate = data.sorted { $0.startTime < $1.startTime }
        let firstDate = sortDate.first?.startTime
        let lastDate = sortDate.last?.startTime
        
        switch indexPediod {
        case 0:
            if firstDate?.firstOfWeek() == date.firstOfWeek() {
                
                return 0
            } else if lastDate?.firstOfWeek() == date.firstOfWeek() {
                
                return 1
            }
        case 1:
            if firstDate?.firstDayOfMonth() == date.firstDayOfMonth() {
                
                return 0
            } else if lastDate?.firstDayOfMonth() == date.firstDayOfMonth() {
                
                return 1
            }
        case 2:
            if firstDate?.firstMonthOfYear() == date.firstMonthOfYear() {
                
                return 0
            } else if lastDate?.firstMonthOfYear() == date.firstMonthOfYear() {
                
                return 1
            }
        default:
            break
        }
        
        return 2
    }
}
