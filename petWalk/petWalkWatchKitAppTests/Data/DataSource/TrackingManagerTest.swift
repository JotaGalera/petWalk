//
//  TrackingManagerTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 3/4/22.
//

import XCTest
@testable import petWalkWatchKitApp

class TrackingManagerTest: XCTestCase {
    private var sut: TrackingManager!
    private var userDefaultsMock: UserDefaultDataSourceMock!
    
    override func setUpWithError() throws {
        userDefaultsMock = UserDefaultDataSourceMock()
        
        sut = TrackingManagerImplementation(userDefaultDataSource: userDefaultsMock)
    }
    
    func testThatDailyStepsTrackingIsEnabled_When_IsTrackingDailyStepsEnabledReturnTrue() {
        userDefaultsMock.trackingDailyStepsPermissionReturnValue = true
        
        let permission = sut.isTrackingDailyStepsEnabled()
        
        XCTAssertTrue(permission)
    }
    
    func testThatStepsTrackingIsDisabled_When_IsTrackingDailyStepsEnabledReturnFalse() {
        userDefaultsMock.trackingDailyStepsPermissionReturnValue = false
        
        sut = TrackingManagerImplementation(userDefaultDataSource: userDefaultsMock)
        let permission = sut.isTrackingDailyStepsEnabled()
        
        XCTAssertFalse(permission)
    }
}
