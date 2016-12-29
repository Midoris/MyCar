//
//  ModelManagerTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ModelManagerTests: XCTestCase {
    
    var sut: Manager!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        sut = Manager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testModelsCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.elementsCount, 0)
    }

    func testManufacturersCount_AfterAddingOneItem_IsOne() {
        sut.add(carElement: Model(name: "Audi"))
        XCTAssertEqual(sut.elementsCount, 1)
    }

    func testManufacturerAtIndex_ShouldReturnPreviouslyAddedItem() {
        let model = Model(name: "Audi")
        sut.add(carElement: model)
        let returnedModel = sut.carElement(at: 0)
        XCTAssertEqual(model.name, returnedModel.name)
    }

    func testRemoveAllManufacturers_ShouldResultInCountBeZero() {
        let model = Model(name: "Audi")
        sut.add(carElement: model)
        XCTAssertEqual(sut.elementsCount, 1)
        sut.removeAllCarElemnts()
        XCTAssertEqual(sut.elementsCount, 0)
    }

}
