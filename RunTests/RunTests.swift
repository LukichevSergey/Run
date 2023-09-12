//
//  RunTests.swift
//  RunTests
//
//  Created by Evgenii Kutasov on 11.09.2023.
//

import XCTest
@testable import Run

final class RunTests: XCTestCase {
    
    var managerTraining: TrainingManager!

    override func setUpWithError() throws {
        managerTraining = TrainingManager()
    }

    override func tearDownWithError() throws {
        managerTraining = nil
        try super.tearDownWithError()
    }

    func testWithPositiveAvarageTemp() throws {
        let km1 = 20.0
        let time = 6.0
        let test1 = managerTraining.getAverageTempModel(dist: km1, time: time)
        let result = "5:00"
        
        XCTAssertTrue(test1 == result)
    }
    
    func testWithPositiveAvarageTemp2KM() throws {
        let km1 = 1060.0
        let time = 321.6
        let test1 = managerTraining.getAverageTempModel(dist: km1, time: time)
        let result = "5:03"
        
        XCTAssertTrue(test1 == result)
    }
    
    func testWithNegativeAvarageTemp() throws {
        let km1 = 20.0
        let time = 5.0
        let test1 = managerTraining.getAverageTempModel(dist: km1, time: time)
        let result = "5:00"
        
        XCTAssertFalse(test1 == result)
    }
    
    func testWithMinusAvarageTemp() throws {
        let km1 = -20.0
        let time = 5.0
        let test1 = managerTraining.getAverageTempModel(dist: km1, time: time)
        let result = "5:00"
        
        XCTAssertFalse(test1 == result)
    }
}
