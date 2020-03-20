//
//  MarvelDemoUITests.swift
//  MarvelDemoUITests
//
//  Created by Berkay Sebat on 3/19/20.
//  Copyright © 2020 marvel. All rights reserved.
//

import XCTest

class MarvelDemoUITests: XCTestCase {
    // MARK: - Lifecyle Methods -
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

    }

    override func tearDown() {
        super.tearDown()
    }
    // MARK: - Test UI -
    func testUI() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(20)
        app.staticTexts["Sentry, the (Trade Paperback)"].tap()
        let predicate = NSPredicate(format: "label BEGINSWITH 'On the edge of alcoholism'")
        let label = app.staticTexts.element(matching: predicate)
        XCTAssert(label.exists)
        }

    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
