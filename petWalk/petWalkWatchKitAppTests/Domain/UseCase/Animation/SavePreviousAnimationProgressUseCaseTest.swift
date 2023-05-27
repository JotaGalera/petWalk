//
//  SavePreviousAnimationProgressUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 21/5/22.
//

import XCTest
@testable import petWalkWatchKitApp

class SavePreviousAnimationProgressUseCaseTest: XCTestCase {
    var sut: SavePreviousAnimationProgressUseCaseImplementation!
    var repository: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = UserDefaultsRepositoryMock()        
        sut = SavePreviousAnimationProgressUseCaseImplementation(repository: repository)
    }
    
    func testThatPreviousAnimationProgressIsSaved_When_ExecuteIsCalled() {
        let progressMock = 0.5
        
        sut.execute(progressMock)
        
        XCTAssertEqual(1, repository.savePreviousAnimationProgressCallsCount)
        XCTAssertEqual(progressMock, repository.savePreviousAnimationProgressReceivedPreviousAnimationProgress)
    }
}
