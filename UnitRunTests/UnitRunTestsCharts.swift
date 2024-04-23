//
//  UnitRunTestsCharts.swift
//  UnitRunTests
//
//  Created by Evgenii Kutasov on 21.04.2024.
//

import XCTest
@testable import Run

final class UnitRunTestsCharts: XCTestCase {
    var chartsModel: ChartsManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        chartsModel = ChartsManager()
    }

    override func tearDownWithError() throws {
        chartsModel = nil
        try super.tearDownWithError()
    }
    /// Тест проверяет  как клик на кнопку вперед определяет следующую неделю
    func testGetPeriodAgoForWeekForward() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day,
                                                                                  value: 7,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 0, buttonMovement: .forward) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест проверяет  как клик на кнопку назад определяет следующую неделю

    func testGetPeriodAgoForWeekBack() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day,
                                                                                  value: -7,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 0, buttonMovement: .back) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест определяет текущую неделю при первом открытие

    func testGetPeriodAgoForWeekCurrent() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day,
                                                                                  value: 0,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 0, buttonMovement: .empty) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест проверяет  как клик на кнопку вперед определяет следующую месяц
    func testGetPeriodAgoForMonthForward() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month,
                                                                                  value: 1,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 1, buttonMovement: .forward) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест проверяет  как клик на кнопку назад определяет следующую месяц

    func testGetPeriodAgoForMonthback() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month,
                                                                                  value: -1,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 1, buttonMovement: .back) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест определяет текущий месяц при первом открытие

    func testGetPeriodAgoForMonthCurrent() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month,
                                                                                  value: 0,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 1, buttonMovement: .empty) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест проверяет  как клик на кнопку вперед определяет следующую год
    func testGetPeriodAgoForYearForward() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .year,
                                                                                  value: 1,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 2, buttonMovement: .forward) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест проверяет  как клик на кнопку назад определяет следующую год

    func testGetPeriodAgoForYearBack() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .year,
                                                                                  value: -1,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 2, buttonMovement: .back) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
    /// Тест определяет текущий год при первом открытие

    func testGetPeriodAgoForYearCurrent() throws {
        let currentDate = Date()
        let expectedDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .year,
                                                                                  value: 0,
                                                                                  to: currentDate)!)
        guard let result = chartsModel.getPeriodAgo(indexPeriod: 2, buttonMovement: .empty) else {
            XCTFail("date nil")
            return
        }
        let resultDate = Calendar.current.startOfDay(for: result)
        XCTAssertEqual(resultDate, expectedDate)
    }
}
