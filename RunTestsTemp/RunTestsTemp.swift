//
//  RunTestsTemp.swift
//  RunTestsTemp
//
//  Created by Evgenii Kutasov on 12.09.2023.
//

import XCTest
@testable import Run

final class RunTestsTemp: XCTestCase {

    var managerTraining: TrainingManager!

    override func setUpWithError() throws {
        managerTraining = TrainingManager()
    }

    override func tearDownWithError() throws {
        managerTraining = nil
        try super.tearDownWithError()
    }

    func testWithPositiveTemp1KM() throws {
        let km1 = 220.0
        let time = 66.0
        let temp = managerTraining.getTempModel(distance: km1, time: time)
        let then = "5:00"
        
        XCTAssertTrue(temp == then)
    }
    
    func testWithPositiveTemp2KM() throws {
        let km1 = 220.0
        let time = 79.2
        let temp = managerTraining.getTempModel(distance: km1, time: time)
        let then = "6:00"
        
        XCTAssertTrue(temp == then)
    }
    
    func testWithNegativeTemp2KM() throws {
        let km1 = 220.0
        let time = 79.0
        let temp = managerTraining.getTempModel(distance: km1, time: time)
        let then = "6:00"
        
        XCTAssertFalse(temp == then)
    }
    
    func testWithNegativeTemp1KM() throws {
        let km1 = 210.0
        let time = 79.2
        let temp = managerTraining.getTempModel(distance: km1, time: time)
        let then = "6:00"
        
        XCTAssertFalse(temp == then)
    }
    
    func testWithMinusTemp1KM() throws {
        let km1 = -210.0
        let time = 79.2
        let temp = managerTraining.getTempModel(distance: km1, time: time)
        let then = "6:00"
        
        XCTAssertFalse(temp == then)
    }
}
