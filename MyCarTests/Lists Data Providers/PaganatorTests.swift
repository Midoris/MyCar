//
//  PaganatorTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class PaganatorTests: XCTestCase {

    var sut: Paganator?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Paganator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformPagination_CallsFtecherMethod() {
        let mockFetcher = MockFetcher()
        sut?.performPagination(for: 12, using: mockFetcher.fetchData, elementsCount: 15)
        XCTAssertEqual(mockFetcher.pageForFetch, 1)
    }

}

extension PaganatorTests {

    class MockFetcher {

        var pageForFetch: Int?

        func fetchData(for page: Int) {
            pageForFetch = page
        }
    }
}
