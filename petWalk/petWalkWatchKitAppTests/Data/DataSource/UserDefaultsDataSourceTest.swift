//
//  UserDefaultsDataSourceTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class UserDefaultsDataSourceTest: XCTestCase {
    private var sut: UserDefaultsDataSource!
    private var userDefaultsMock: UserDefaults!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaultsMock = UserDefaults(suiteName: "suitMocked")
        userDefaultsMock.removePersistentDomain(forName: "suitMocked")
        
        sut = UserDefaultsDataSourceImplementation(userDefault: userDefaultsMock)
    }

    func testThatDailyStepsAreReadableFromMemory_When_TheyWereSaved() throws {
        let valueMocked: Int = 10
        sut.set(value: valueMocked, forKey: .accumulatedDailySteps)
        
        XCTAssertEqual(10, sut.get(forKey: .accumulatedDailySteps))
    }
}
