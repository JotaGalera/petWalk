//
//  PetDataViewUITests.swift
//  petWalk WatchKit AppUITests
//
//  Created by Galera, Javier on 3/1/22.
//

import XCTest

class PetDataViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testPetDataViewIsDisplayedProperly() throws {
        let app = XCUIApplication()
        app.launch()

        app.images["strength"].tap()

        let petExpLabel = app.staticTexts["Exp"]
        let petNextLvlLabel = app.staticTexts["NextLevel"]
        
        XCTAssert(petExpLabel.exists)
        XCTAssert(petNextLvlLabel.exists)
    }
}
