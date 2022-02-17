//
//  UtilsTest.swift
//  petWalkWatchKitAppTests
//
//  Created by Galera, Javier on 17/2/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func waitForExpectation(timeOut: Double) {
        waitForExpectations(timeout: timeOut) { error in
            if let error = error {
                XCTFail("Timeout: \(error.localizedDescription)")
            }
        }
    }
}
