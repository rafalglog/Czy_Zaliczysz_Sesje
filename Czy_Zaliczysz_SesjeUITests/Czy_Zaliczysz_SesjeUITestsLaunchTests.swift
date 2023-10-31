//
//  Czy_Zaliczysz_SesjeUITestsLaunchTests.swift
//  Czy_Zaliczysz_SesjeUITests
//
//  Created by Rafal Glogowski on 31/10/2023.
//

import XCTest

final class Czy_Zaliczysz_SesjeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
