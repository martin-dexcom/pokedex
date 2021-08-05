//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Martin García on 7/12/21.
//

import XCTest

class PokedexUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

      try super.setUpWithError()

      // In UI tests it is usually best to stop immediately when a failure occurs.
      continueAfterFailure = false

      app = XCUIApplication()
      app.launch()

      // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
      app = nil
      try super.tearDownWithError()
    }

    func testExample() {
      let tabBar = XCUIApplication().tabBars["Tab Bar"]
      tabBar.buttons["Discovery"].tap()
      tabBar.buttons["Pokedex"].tap()
      tabBar.buttons["Search"].tap()
    }

    func testTabBarGraphsButton_CountNumberOfButtons() {
      let tabBar = XCUIApplication().tabBars["Tab Bar"]
      XCTAssertEqual(tabBar.buttons.count, 3, "Expected to have 3 tabbar items")

    }

    func testTappingOnDiscoveryTabBar() {
      let tabBar = XCUIApplication().tabBars["Tab Bar"]
      tabBar.buttons["Discovery"].tap()
      XCTAssertTrue(tabBar.buttons["Discovery"].isSelected, "The discovery button was not selected")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
