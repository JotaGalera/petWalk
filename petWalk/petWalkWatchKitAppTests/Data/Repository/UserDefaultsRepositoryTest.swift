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
    
    func testDailyStepsAreSavedOnMemory_When_SaveDailyStepsIsCalled() throws {
        let stepsMocked = 10
        
        sut.saveDailySteps(stepsMocked)
        
        XCTAssertEqual(1, dataSource.setCallsCount)
    }
}

class UserDefaultDataSourceMock: UserDefaultsDataSource {
    var getCallsCount = 0
    var setCallsCount = 0
    var setParamValueReceived: Any!
    
    func get<T>(forKey: UserDefaultsKeys) -> T? {
        getCallsCount += 1
        return nil
    }
    
    func set<T>(value: T, forKey: UserDefaultsKeys) {
        setCallsCount += 1
        setParamValueReceived = value
    }
    
    
}
