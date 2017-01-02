//
//  ModelCellSelectionNotificatorTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ModelCellSelectionNotificatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNotifyCellSelection_CallsPostNotification() {
        let num = 5
        let mockModelCellSelectionNotificator = MockModelCellSelectionNotificator()
        mockModelCellSelectionNotificator.notifyCellSelection(at: num)
        XCTAssertEqual(mockModelCellSelectionNotificator.postNotificationNumber, num)
    }

    func testNotifyCellSelection_PostsNotification() {
        let sut = ModelCellSelectionNotificator()
        expectation(forNotification: GlobalConstants.ModelCellSelectedNotificationID, object: nil) { (notification) -> Bool in
            guard let index = notification.userInfo?[GlobalConstants.NotificationUserInfoKey] as? Int else {
                return false
            }
            return index == 0
        }
        sut.notifyCellSelection(at: 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

}


extension ModelCellSelectionNotificatorTests {

    class MockModelCellSelectionNotificator: ModelCellSelectionNotificator {

        var postNotificationNumber: Int?

        override func postNotification(with num: Int) {
            self.postNotificationNumber = num
        }
    }
}
