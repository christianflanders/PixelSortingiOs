//
//  UITests.swift
//  PixelSortingUITests
//
//  Created by Christian Flanders on 8/2/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
        
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
        app.collectionViews["PhotosGridView"].cells["Photo, Portrait, July 27, 1:19 PM"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 1").element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 2").element.tap()
        
        let effect3Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 3").element
        effect3Element.tap()
        effect3Element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 4").element.tap()
        
        let effect5Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 5").element
        effect5Element.tap()
        effect5Element.swipeLeft()
        effect5Element.tap()
        
        let effect6Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 6").element
        effect6Element.tap()
        effect6Element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 7").element.tap()
        
        let effect8Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 8").element
        effect8Element.swipeLeft()
        effect8Element.swipeLeft()
        
        let effect9Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 9").element
        effect9Element.tap()
        effect9Element.swipeLeft()
        effect9Element.tap()
        effect9Element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Effect 10").element.tap()
        
        let effect11Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 11").element
        effect11Element.tap()
        effect11Element.swipeLeft()
        
        let effect12Element = cellsQuery.otherElements.containing(.staticText, identifier:"Effect 12").element
        effect12Element.swipeLeft()
        effect12Element.tap()
        
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
