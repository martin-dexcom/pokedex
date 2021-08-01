//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Martin García on 7/24/21.
//

import XCTest

class PokedexUITests: XCTestCase {
    var application: XCUIApplication?

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        application = XCUIApplication()
        application?.launch()
        print("Set up with error")
    }
    
    func test_searchingWithSearchbar_yields_oneResult() {
        // Arrange
        // get my application instance
        guard let application = application else { return }
        // get tab bar
        let tabBar = application.tabBars
        // Im going to make sure that Im on the discovery tab
        tabBar.buttons["Discovery"].tap()
        // get an instance of my searchbar
        let searchField = application.otherElements["PokemonNameSearchDiscovery"]
        searchField.tap()
        
        // Act
        // search for charizard
        searchField.typeText("Chari")
        
        // Press enter
        application.keyboards.buttons["search"].tap()
        
        // Assert
        // check if it exists
        XCTAssertGreaterThan(application.tables.cells.count, 0)
    }
    
    // Be back in 45 :) 
    
    func test_touchingTabs_should_moveTheUI() {
        // Arrange
        // I want to get everything I need to run my test.
        guard let application = application else {
            return
        }
        
        let tabBar = application.tabBars
        
        // Act
        // I want to do the actions to test them
        tabBar.buttons["Search"].tap()
        Thread.sleep(forTimeInterval: 2)
        tabBar.buttons["Pokedex"].tap()
        Thread.sleep(forTimeInterval: 2)
        tabBar.buttons["Discovery"].tap()
        // Assert
        XCTAssertNotNil(application.staticTexts.element(matching: .any, identifier: "What Pokemon are you looking for?"))
        
        // If what I thought would happen, happened.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
