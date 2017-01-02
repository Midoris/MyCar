//
//  ManufacturersParserTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ManufacturersParserTests: XCTestCase {

    var sut: ManufacturersParser!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        sut = ManufacturersParser()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParse_ReturnsAndSortedParsedModels() {
        let dictForParse = ["wkda": ["020" : "Abarth", "107": "Bentley"]]
        let firsrManufacturer = Manufacturer(id: "020", name: "Abarth")
        let secondManufacturer = Manufacturer(id: "107", name: "Bentley")
        let expectedResult = [firsrManufacturer, secondManufacturer]
        let result = sut.parse(carElementsDict: dictForParse as [String : AnyObject])
        XCTAssertEqual(expectedResult[0].name, result[0].name)
        XCTAssertEqual(expectedResult[1].name, result[1].name)
    }
    
}
