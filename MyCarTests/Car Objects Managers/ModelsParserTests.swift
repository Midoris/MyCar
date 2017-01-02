//
//  ModelsParserTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest

@testable import MyCar

class ModelsParserTests: XCTestCase {

    var sut: ModelsParser!
    
    override func setUp() {
        super.setUp()
        sut = ModelsParser()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse_ReturnsAndSortedParsedManufacturers() {
        let dictForParse = ["wkda": ["Arnage" : "Arnage", "Continental GT": "Continental GT"]]
        let firsrModel = Model(name: "Arnage")
        let secondModel = Model(name: "Continental GT")
        let expectedResult = [firsrModel, secondModel]
        let result = sut.parse(carElementsDict: dictForParse as [String : AnyObject])
        XCTAssertEqual(expectedResult[0].name, result[0].name)
        XCTAssertEqual(expectedResult[1].name, result[1].name)
    }

}
