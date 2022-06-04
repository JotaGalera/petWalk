//
//  GetPetDataUseCaseTests.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 4/6/22.
//

@testable import petWalkWatchKitExtension
import XCTest

class GetPetDataUseCaseTests: XCTestCase {
    private var sut: GetPetDataUseCase!
    
    override func setUpWithError() throws {
        sut = GetPetDataUseCaseImplementation()
    }
    
    func testThatAPetIsReturned_When_GetPetDataUseCaseIsCalled() {
        let petMock = Swordman(name: "Beldrick", level: Level(), stats: Stats())
        
        let pet = sut.execute()
        
        XCTAssertEqual(petMock, pet as! Swordman)
    }
}

