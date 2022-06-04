//
//  PetsTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 28/5/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class PetsTest: XCTestCase {
    var sut: Pets!
    var levelMock = Level()
    var statsMock = Stats()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = Swordman(name: "test", level: levelMock, stats: statsMock)
    }
    
    func testThatNewLevelAndNewStatsAreCalculatedProperly_When_PetLevelUp() {
        sut.levelUp()
        
        XCTAssertEqual(2, sut.level.currentLevel)
        XCTAssertEqual(11, sut.stats.strength)
        XCTAssertEqual(12, sut.stats.life)
    }
    
    func testThatNextExpToLevelUpIsCalcuatedProperly_When_PetLevelUp() {
        sut.levelUp()
        
        XCTAssertEqual(2, sut.level.currentLevel)
        XCTAssertEqual(300, sut.level.expToLevelUp)
        
        sut.levelUp()
        
        XCTAssertEqual(3, sut.level.currentLevel)
        XCTAssertEqual(600, sut.level.expToLevelUp)
        
        sut.levelUp()
        
        XCTAssertEqual(4, sut.level.currentLevel)
        XCTAssertEqual(1000, sut.level.expToLevelUp)
    }
}
