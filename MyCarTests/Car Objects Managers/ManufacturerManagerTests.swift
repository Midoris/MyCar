//
//  ManufacturerManagerTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest

@testable import MyCar

class ManufacturerManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testManufacturerCount_Initially_ShouldBeZero() {
        let manufacturerManager = ManufacturerManager()
        XCTAssertEqual(manufacturerManager.manufacturersCount, 0)
    }
    
    
}
