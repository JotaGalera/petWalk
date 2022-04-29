//
//  PetViewUITests.swift
//  petWalk WatchKit AppUITests
//
//  Created by Galera, Javier on 3/1/22.
//

import XCTest

class PetViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testPetViewIsDisplayedProperly() throws {
        let app = XCUIApplication()
        app.launch()

        let petName = app.staticTexts["Beldrick"]
        let strengthPet = app.images["strength"]
        let lifePet = app.images["life"]
        
        XCTAssert(petName.exists)
        XCTAssert(strengthPet.exists)
        XCTAssert(lifePet.exists)
    }
    
    func testThatPetDataViewIsDisplayed_When_StrengthLabel_And_LifeLabelAreClicked() throws {
        let app = XCUIApplication()
        app.launch()
        
        let petName = app.staticTexts["Beldrick"]
        XCTAssert(petName.exists)
        app.images["strength"].tap()
        
        let petExp = app.staticTexts["Exp"]
        XCTAssert(petExp.exists)
        
        app.navigationBars.buttons["BackButton"].tap()
        XCTAssert(petName.exists)
        
        app.images["life"].tap()
        XCTAssert(petExp.exists)
        
    }
        
}
