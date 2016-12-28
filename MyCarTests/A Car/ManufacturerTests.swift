//
//  ManufacturerTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest

@testable import MyCar

class ManufacturerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldSetId() {
        let manufacturer = Manufacturer(id: "101", name: "Audi")
        XCTAssertEqual(manufacturer.id, "101")
    }

    func testInit_ShouldSetName() {
        let manufacturer = Manufacturer(id: "070", name: "BMW")
        XCTAssertEqual(manufacturer.name, "BMW")
    }
    
}
