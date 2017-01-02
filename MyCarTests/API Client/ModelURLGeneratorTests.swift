//
//  ModelURLGeneratorTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ModelURLGeneratorTests: XCTestCase {

    var sut: ModelURLGenerator!
    let manufacturerID = "101"
    
    override func setUp() {
        super.setUp()
        sut = ModelURLGenerator(manufacturerID: manufacturerID)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testURLForPage_ReturnsExpectedURL() {
        let page = 3
        let expectedURL = URL(string: "\(URLElementsConstsnts.BaseURL)/v1/car-types/main-types?manufacturer=\(manufacturerID)&page=\(page)&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
        let resultURL = try? sut.urlFor(page: page)
        XCTAssertEqual(resultURL, expectedURL)
    }
    

}
