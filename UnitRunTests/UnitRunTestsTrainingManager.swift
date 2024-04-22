//
//  UnitRunTests.swift
//  UnitRunTests
//
//  Created by Evgenii Kutasov on 20.04.2024.
//

import XCTest
import CoreLocation
@testable import Run

final class UnitRunTestsTrainingManager: XCTestCase {
    var trainingManager: TrainingManager!

    override func setUpWithError() throws {
        trainingManager = TrainingManager(user: AppUser(id: "fnN8QcRtnQaXrvnWGHAXlni9oCJ3", name: "zzz111@ma.ru"))
    }

    override func tearDownWithError() throws {
        trainingManager = nil
    }
    /// Тест для проверки подсчета вреднего времени
    func testAverageTimeTemp() throws {
        let averageTimeTemp = trainingManager.getAverageTempModel(distance: 220, time: 66)
        XCTAssertEqual(averageTimeTemp, "5:00")
    }
    /// Тест для проверки подсчета одного километра для вывода в UI
    func testTempModel1KM() throws {
        let distance = 230.0
        let time = 69.0
        let kmTraveled = 0.0
        let kmIteration = 0
        let timeAllKM = 0.0
        let tempmodel = trainingManager.getTempModel(distance: distance,
                                                     time: time,
                                                     kmTraveled: kmTraveled,
                                                     kmIteration: kmIteration,
                                                     timeAllKM: timeAllKM)
        XCTAssertEqual(tempmodel, "5:00")
    }
    /// Тест для проверки подсчета второго километра с тестовыми данными
    func testTempModel2KM() throws {
        let time = 210.0
        let distance = 600.0
        let kmTraveled = 1.0
        let kmIteration = 1
        let timeAllKM = 0.3
        let tempmodel = trainingManager.getTempModel(distance: distance,
                                                     time: time,
                                                     kmTraveled: kmTraveled,
                                                     kmIteration: kmIteration,
                                                     timeAllKM: timeAllKM)
        XCTAssertEqual(tempmodel, "5:50")
    }
    /// Тест для проверки что функция отрабатывает верно
    func testGetDistanceWithNoCoordinates() {
        let distance = trainingManager.getDistance()
        XCTAssertEqual(distance, 0)
    }
    /// Тест для проверки что дистанция считается с тестовыми данными
    func testGetDistanceWithCoordinates() {
        trainingManager.createTraining()
        let coordinates = [
             CLLocationCoordinate2D(latitude: 55.097225, longitude: 82.958459),
             CLLocationCoordinate2D(latitude: 55.097677, longitude: 82.959853)
         ]
         trainingManager.updateTraining(with: coordinates)
         let distance = trainingManager.getDistance()
        XCTAssertGreaterThan(distance, 1)
    }
    /// Тест для проверки что первые координаты не перезаписываются
    func testSaveCityForDetailedTraining_WhenCityExists() {
        let latitude = 100.0
        let longitude = 199.0
        let initialLatitude = 200.0
        let initialLongitude = 299.0
        trainingManager.createTraining()
        trainingManager.currentTraining?.coordinatesCity.latitude = initialLatitude
        trainingManager.currentTraining?.coordinatesCity.longitude = initialLongitude
        trainingManager.saveCityForDetailedTraining(latitude, longitude)
        XCTAssertEqual(trainingManager.currentTraining?.coordinatesCity.latitude, initialLatitude)
        XCTAssertEqual(trainingManager.currentTraining?.coordinatesCity.longitude, initialLongitude)
    }
    /// Тест для проверки что если первых значениф не было то первые полученые записываются корректно
    func testSaveCityForDetailedTraining_WhenNoCityExists() {
        let latitude = 55.0
        let longitude = 82.0
        trainingManager.createTraining()
        trainingManager.saveCityForDetailedTraining(latitude, longitude)
        XCTAssertEqual(trainingManager.currentTraining?.coordinatesCity.latitude, latitude, "lat is enabled")
        XCTAssertEqual(trainingManager.currentTraining?.coordinatesCity.longitude, longitude, "lot is enabled ")
    }
}
