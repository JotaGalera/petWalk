//
//  GetPreviousAnimationProgressUseCaseTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 21/5/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class GetPreviousAnimationProgressUseCaseTest: XCTestCase{
    var sut: GetPreviousAnimationProgressUseCaseImplementation!
    var repositoty: UserDefaultsRepositoryMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repositoty = UserDefaultsRepositoryMock()
        sut = GetPreviousAnimationProgressUseCaseImplementation(repository: repositoty)
    }
    
    func testThatPreviousAnimationProgressIsObtained_When_ExecuteIsCalled() {
        repositoty.getPreviousAnimationProgressReturnValue = 40.0
        
        let progressMock = sut.execute()
        
        XCTAssertEqual(1, repositoty.getPreviousAnimationProgressCallsCount)
        XCTAssertEqual(progressMock, repositoty.getPreviousAnimationProgressReturnValue)
    }
}
