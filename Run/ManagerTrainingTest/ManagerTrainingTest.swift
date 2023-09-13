//
//  ManagerTrainingTest.swift
//  ManagerTrainingTest
//
//  Created by Evgenii Kutasov on 13.09.2023.
//

import XCTest
@testable import Run


final class ManagerTrainingTest: XCTestCase {
    
    var managerTraining: TrainingManager!

    override func setUpWithError() throws {
        managerTraining = TrainingManager()
    }

    override func tearDownWithError() throws {
        managerTraining = nil
        try super.tearDownWithError()
    }

    //MARK: - Test method Average temp
    func testWithPositiveAvarageTemp() throws {
        let guessKilometr = 20.0
        let guestime = 6.0
        let ThenAVGTemp = managerTraining.getAverageTempModel(dist: guessKilometr, time: guestime)
        let endResult = "5:00"
        
        XCTAssertTrue(ThenAVGTemp == endResult)
    }
    
    func testWithPositiveAvarageTemp2KM() throws {
        let guessKilometr = 1060.0
        let guestime = 321.6
        let ThenAVGTemp = managerTraining.getAverageTempModel(dist: guessKilometr, time: guestime)
        let endResult = "5:03"
        
        XCTAssertTrue(ThenAVGTemp == endResult)
    }
    
    func testWithNegativeAvarageTemp() throws {
        let guessKilometr = -20.0
        let guestime = 5.0
        let ThenAVGTemp = managerTraining.getAverageTempModel(dist: guessKilometr, time: guestime)
        let endResult = "5:00"
        
        XCTAssertFalse(ThenAVGTemp == endResult)
    }
    
    func testWithMinusAvarageTemp() throws {
        let guessKilometr = -20.0
        let guestime = 5.0
        let ThenAVGTemp = managerTraining.getAverageTempModel(dist: guessKilometr, time: guestime)
        let endResult = "5:00"
        
        XCTAssertFalse(ThenAVGTemp == endResult)
    }
    
    //MARK: - Test method temp
    func testWithPositiveTemp1KM() throws {
        let guessKilometr = 220.0
        let guestime = 66.0
        let ThenTemp = managerTraining.getTempModel(distance: guessKilometr, time: guestime)
        let endResult = "5:00"
        
        XCTAssertTrue(ThenTemp == endResult)
    }
    
    func testWithPositiveTemp2KM() throws {
        let guessKilometr = 220.0
        let guestime = 79.2
        let ThenTemp = managerTraining.getTempModel(distance: guessKilometr, time: guestime)
        let endResult = "6:00"
        
        XCTAssertTrue(ThenTemp == endResult)
    }
    
    func testWithNegativeTemp1KM() throws {
        let guessKilometr = 210.0
        let guestime = 79.2
        let ThenTemp = managerTraining.getTempModel(distance: guessKilometr, time: guestime)
        let endResult = "6:00"
        
        XCTAssertFalse(ThenTemp == endResult)
    }
    
    func testWithMinusTemp1KM() throws {
    
        let guessKilometr = 210.0
        let guestime = 79.2
        let ThenTemp = managerTraining.getTempModel(distance: guessKilometr, time: guestime)
        let endResult = "6:00"
        
        XCTAssertFalse(ThenTemp == endResult)
    }
}
