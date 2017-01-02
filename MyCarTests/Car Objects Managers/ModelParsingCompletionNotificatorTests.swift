//
//  ModelParsingCompletionNotificatorTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ModelParsingCompletionNotificatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNotifyParsingCompletion_PostsNotification() {
        let sut = ModelParsingCompletionNotificator()
        expectation(forNotification: GlobalConstants.ModelsParsingCompletedNotificationID, object: nil) { (notification) -> Bool in
            return true
        }
        sut.notifyParsingCompletion()
        waitForExpectations(timeout: 3, handler: nil)
    }
}
