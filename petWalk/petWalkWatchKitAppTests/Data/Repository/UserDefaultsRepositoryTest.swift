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
    
    func testThatDailyStepsAreSavedOnMemory_When_SaveDailyStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveAccumulatedDailySteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(10, dataSource.setParamValueReceived as! Int)
        XCTAssertEqual(.accumulatedDailySteps, dataSource.setParamForKeyReceived)
    }
    
    func testThatTotalStepsAreSavedOnMemory_When_SaveTotalStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveTotalSteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(10, dataSource.setParamValueReceived as! Int)
        XCTAssertEqual(.totalSteps, dataSource.setParamForKeyReceived)
    }
    
    func testThatDateDailyStepsAreSavedOnMemory_When_SaveDateDailyStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveTotalSteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
        XCTAssertEqual(10, dataSource.setParamValueReceived as! Int)
        XCTAssertEqual(.totalSteps, dataSource.setParamForKeyReceived)
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
        XCTAssertEqual(dataSource.dateMock, dateDailySteps)
    }
}

class UserDefaultDataSourceMock: UserDefaultsDataSource {
    var getCallsCount = 0
    var getParamForKeyReceived: UserDefaultsKeys!
    var getReturnValue: Any!
    var dateMock = Date()
    var setCallsCount = 0
    var setParamValueReceived: Any!
    var setParamForKeyReceived: UserDefaultsKeys!
    
    func get<T>(forKey: UserDefaultsKeys) -> T? {
        getCallsCount += 1
        getParamForKeyReceived = forKey
        switch forKey {
        case .accumulatedDailySteps:
            getReturnValue = 10
        case .totalSteps:
            getReturnValue = 100
        case .dateDailySteps:
            getReturnValue = dateMock
        }
        return getReturnValue as? T
    }
    
    func set<T>(value: T, forKey: UserDefaultsKeys) {
        setCallsCount += 1
        setParamValueReceived = value
        setParamForKeyReceived = forKey
    }
    
    
}
