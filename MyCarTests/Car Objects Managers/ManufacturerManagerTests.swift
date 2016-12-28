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

    var sut: ManufacturerManager!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        sut = ManufacturerManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testManufacturersCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.manufacturersCount, 0)
    }

    func testManufacturersCount_AfterAddingOneItem_IsOne() {
        sut.add(manufacturer: Manufacturer(id: "101", name: "BMW"))
        XCTAssertEqual(sut.manufacturersCount, 1)
    }

    func testManufacturerAtIndex_ShouldReturnPreviouslyAddedItem() {
        let manufacturer = Manufacturer(id: "101", name: "BMW")
        sut.add(manufacturer: manufacturer)
        let returnedManufacturer = sut.manufacturer(at: 0)
        XCTAssertEqual(manufacturer.id, returnedManufacturer.id)
        XCTAssertEqual(manufacturer.name, returnedManufacturer.name)
    }

    func testRemoveAllManufacturers_ShouldResultInCountBeZero() {
        let manufacturer = Manufacturer(id: "101", name: "BMW")
        sut.add(manufacturer: manufacturer)
        XCTAssertEqual(sut.manufacturersCount, 1)
        sut.removeAllManufacturers()
        XCTAssertEqual(sut.manufacturersCount, 0)
    }
    
    
}
