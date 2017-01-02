//
//  CarViewControllerTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class CarViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testViewDidLoad_CallsshowSelectedCarAlert() {
        let mockSut = MockCarViewController()
        mockSut.car = Car(manufacturer: Manufacturer(id: "101", name: "BMW"), model: Model(name: "M#"))
        _ = mockSut.view
        XCTAssertTrue(mockSut.showSelectedCarAlertGotCalled)
    }

}

extension CarViewControllerTests {

    class MockCarViewController: CarViewController {

        var showSelectedCarAlertGotCalled = false

        override func showSelectedCarAlert() {
            super.showSelectedCarAlert()
            showSelectedCarAlertGotCalled = true
        }
    }
}
