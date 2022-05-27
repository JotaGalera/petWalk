//
//  UserDefaultsRepositoryTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class UserDefaultsRepositoryTest: XCTestCase {
    private var sut: UserDefaultsRepository!
    private var dataSource: UserDefaultDataSourceMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataSource = UserDefaultDataSourceMock()
        
        sut = UserDefaultsRepositoryImplementation(userDefaultDataSource: dataSource)
    }
    
    func testThatTrackingDailyStepsIsSavedOnMemory_When_SaveTrackingDailyStepsIsCalled() {
        let permission = true
        
        sut.saveTrackingDailySteps(permission)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(permission, dataSource.setParamValueReceived as! Bool)
        XCTAssertEqual(.trackingDailyStepsPermission, dataSource.setParamForKeyReceived)

    }
    
    func testThatDailyStepsAreSavedOnMemory_When_SaveDailyStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveAccumulatedDailySteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(stepsMocked, dataSource.setParamValueReceived as! Int)
        XCTAssertEqual(.accumulatedDailySteps, dataSource.setParamForKeyReceived)
    }
    
    func testThatTotalStepsAreSavedOnMemory_When_SaveTotalStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveTotalSteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(stepsMocked, dataSource.setParamValueReceived as! Int)
        XCTAssertEqual(.totalSteps, dataSource.setParamForKeyReceived)
    }
    
    func testThatDateDailyStepsAreSavedOnMemory_When_SaveDateDailyStepsIsCalled() throws {
        let date = Date()
        
        sut.saveDateDailySteps(date)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(date, dataSource.setParamValueReceived as! Date)
        XCTAssertEqual(.dateDailySteps, dataSource.setParamForKeyReceived)
    }
    
    func testThatAccumulatedDailyStepsAreRequested_When_GetAccumulatedDailyStepsIsCalled() {
        let accumulatedDailySteps = sut.getAccumulatedDailySteps()
        
        XCTAssertEqual(1, dataSource.getCallsCount)
        XCTAssertEqual(.accumulatedDailySteps, dataSource.getParamForKeyReceived)
        XCTAssertEqual(10, accumulatedDailySteps)
    }
    
    func testThatTotalStepsAreRequested_When_GetTotalStepsIsCalled() {
        let totalSteps = sut.getTotalSteps()
        
        XCTAssertEqual(1, dataSource.getCallsCount)
        XCTAssertEqual(.totalSteps, dataSource.getParamForKeyReceived)
        XCTAssertEqual(100, totalSteps)
    }
    
    func testThatDateDailyStepsAreRequested_When_GetDateDailyStepsIsCalled() {
        let dateDailySteps = sut.getDateDailySteps()
        
        XCTAssertEqual(1, dataSource.getCallsCount)
        XCTAssertEqual(.dateDailySteps, dataSource.getParamForKeyReceived)
        XCTAssertEqual(dataSource.dateDailyStepsReturnValue, dateDailySteps)
    }
    
    func testThatPreviousAnimationProgressIsObtained_When_() {
        let previousAnimationProgressMock = sut.getPreviousAnimationProgress()
        
        XCTAssertEqual(1, dataSource.getCallsCount)
        XCTAssertEqual(.previousAnimationProgress, dataSource.getParamForKeyReceived)
        XCTAssertEqual(40.0, previousAnimationProgressMock)
    }
    
    func testThatPreviousAnimationProgressIsSaved_When_() {
        let previousAnimationProgressMock = 50.0
        
        sut.savePreviousAnimationProgress(previousAnimationProgressMock)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(previousAnimationProgressMock, dataSource.setParamValueReceived as! Double)
        XCTAssertEqual(.previousAnimationProgress, dataSource.setParamForKeyReceived)
    }
}
