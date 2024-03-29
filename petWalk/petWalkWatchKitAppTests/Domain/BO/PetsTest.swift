//
//  PetsTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 28/5/22.
//

import XCTest
@testable import petWalkWatchKitApp

class PetsTest: XCTestCase {
    var sut: Pets!
    var levelMock = Level()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = Pet(name: "test", rol: nil, level: levelMock)
    }
    
    func testThatNewLevelAndNewStatsAreCalculatedProperly_When_PetLevelUp() {
        sut.levelUp()
        
        XCTAssertEqual(2, sut.level.currentLevel)
        XCTAssertEqual(13, sut.stats.strength)
        XCTAssertEqual(13, sut.stats.life)
        
        sut.levelUp()
        
        XCTAssertEqual(3, sut.level.currentLevel)
        XCTAssertEqual(15, sut.stats.strength)
        XCTAssertEqual(14, sut.stats.life)
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
