//
//  PixelSortingUITests.swift
//  PixelSortingUITests
//
//  Created by Christian Flanders on 7/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import XCTest

class PixelSortingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    

    func testExample() {
        let app = XCUIApplication()
        app.buttons["Import From Library"].tap()
        app.tables.buttons["Moments"].tap()
        app.collectionViews["PhotosGridView"].cells["Photo, Landscape, 1:19 PM"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 1").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 2").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 3").element.tap()        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
