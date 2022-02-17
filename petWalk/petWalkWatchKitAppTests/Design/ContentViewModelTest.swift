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
    private var getDailyStepsUseCaseMock: GetDailyStepsUseCaseMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        requestDailyStepsPermissionUseCaseMock = RequestDailyStepsPermissionUseCaseMock()
        saveDailyStepsUseCaseMock = SaveDailyStepsUseCaseMock()
        getDailyStepsUseCaseMock = GetDailyStepsUseCaseMock()
        
        sut = ContentViewModel(requestDailyStepsPermissionUseCase: requestDailyStepsPermissionUseCaseMock,
                               saveDailyStepsUseCase: saveDailyStepsUseCaseMock,
                               getDailyStepsUseCase: getDailyStepsUseCaseMock)
    }

    func testExample() throws {
        requestDailyStepsPermissionUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(true)
        }
        getDailyStepsUseCaseMock.executeCompletionClosure = { onSuccess in
            onSuccess(10)
        }
        
        self.sut.requestPermissions()
        
        XCTAssertEqual(1, requestDailyStepsPermissionUseCaseMock.executeCompletionCallsCount)
        XCTAssertEqual(2, getDailyStepsUseCaseMock.executeCompletionCallsCount)
        XCTAssertEqual(1, saveDailyStepsUseCaseMock.executeCallsCount)
    }
}
