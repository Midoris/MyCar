//
//  CarTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class CarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit_ShouldSetManufacturerAndModel() {
        let manufacturer = Manufacturer(id: "111", name: "Audi")
        let model = Model(name: "A8")
        let car = Car(manufacturer: manufacturer, model: model)
        XCTAssertEqual(model.name, car.model.name)
        XCTAssertEqual(manufacturer.name, car.manufacturer.name)
    }

}
