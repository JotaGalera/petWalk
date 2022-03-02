//
//  ContentViewModelTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import XCTest
@testable import petWalkWatchKitExtension

class ContentViewModelTest: XCTestCase {
    private var sut: ContentViewModel!
    private var requestDailyStepsPermissionUseCaseMock: RequestDailyStepsPermissionUseCaseMock!
    private var saveDailyStepsUseCaseMock: SaveDailyStepsUseCaseMock!
    private var saveTotalDailyStepsUseCaseMock : SaveTotalStepsUseCaseMock!
    private var getDailyStepsUseCaseMock: GetDailyStepsUseCaseMock!
    private var getAccumulatedDailyStepsUseCase: GetAccumulatedDailyStepsUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestDailyStepsPermissionUseCaseMock = RequestDailyStepsPermissionUseCaseMock()
        saveDailyStepsUseCaseMock = SaveDailyStepsUseCaseMock()
        saveTotalDailyStepsUseCaseMock = SaveTotalStepsUseCaseMock()
        getDailyStepsUseCaseMock = GetDailyStepsUseCaseMock()
        getAccumulatedDailyStepsUseCase = GetAccumulatedDailyStepsUseCaseMock()
        
        sut = ContentViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCaseMock,
                               saveDailyStepsUseCase: saveDailyStepsUseCaseMock,
                               saveTotalDailyStepsUseCase: saveTotalDailyStepsUseCaseMock,
                               getDailyStepsUseCase: getDailyStepsUseCaseMock,
                               getAccumulatedDailyStepsUseCase: getAccumulatedDailyStepsUseCase)
    }

    func testThatDailyStepsAreReceived_When_PermissionIsGranted() throws {
        requestDailyStepsPermissionUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        getDailyStepsUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(10)
        }
        getAccumulatedDailyStepsUseCase.executeReturnValue = 0
        
        self.sut.requestPermissions()
        
        XCTAssertEqual(1, requestDailyStepsPermissionUseCaseMock.executeCompletionCallsCount)
        XCTAssertEqual(1, getDailyStepsUseCaseMock.executeCompletionCallsCount)
        XCTAssertEqual(1, saveDailyStepsUseCaseMock.executeCallsCount)
    }
    
    func testThatDailyStepsAreUpdated_When_PermissionIsGranted() throws {
        let expectation = expectation(description: "accumulated daily steps updated")
        requestDailyStepsPermissionUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        getDailyStepsUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(10)
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        }
        getAccumulatedDailyStepsUseCase.executeReturnValue = 20
        
        self.sut.requestPermissions()
        
        waitForExpectation(timeOut: 3)
        XCTAssertEqual(10, sut.currentSteps)
    }
    
    func testThatAnimationDailyStepsAreUpdated_When_PermissionIsGranted_And_ThereArePreviousSteps() throws {
        let expectation = expectation(description: "accumulated daily steps updated")
        requestDailyStepsPermissionUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        getDailyStepsUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(40)
            expectation.fulfill()
        }
        getAccumulatedDailyStepsUseCase.executeReturnValue = 20
        
        self.sut.requestPermissions()
        
        waitForExpectation(timeOut: 3)
        XCTAssertEqual(20, sut.animationDailySteps)
    }
}
