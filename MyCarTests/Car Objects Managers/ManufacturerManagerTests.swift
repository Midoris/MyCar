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

    var sut: CarElementsManager!
    var mockAPIClient: MockAPIClient?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let paresrNotificator = ManufacturerParsingCompletionNotificator()
        let parser = ManufacturersParser()
        let manufacturerURLGenerator = ManufacturerURLGenerator()
        let apiClient = APIClient()
        mockAPIClient = MockAPIClient()

        sut = CarElementsManager(parser: parser, notificator: paresrNotificator, urlGenerator: manufacturerURLGenerator, apiClient: mockAPIClient!)
    }

    override func tearDown() {
        sut.removeAllCarElemnts()
        sut = nil
        super.tearDown()
    }

    func testManufacturersCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.elementsCount, 0)
    }

    func testManufacturersCount_AfterAddingOneItem_IsOne() {
        sut.add(parsedCarElements: [Manufacturer(id: "101", name: "BMW")])
        XCTAssertEqual(sut.elementsCount, 1)
    }

    func testManufacturerAtIndex_ShouldReturnPreviouslyAddedItem() {
        let manufacturer = Manufacturer(id: "101", name: "BMW")
        sut.add(parsedCarElements: [manufacturer])
        let returnedManufacturer = sut.carElement(at: 0) as! Manufacturer
        XCTAssertEqual(manufacturer.id, returnedManufacturer.id)
        XCTAssertEqual(manufacturer.name, returnedManufacturer.name)
    }

    func testRemoveAllManufacturers_ShouldResultInCountBeZero() {
        let manufacturer = Manufacturer(id: "101", name: "BMW")
        sut.add(parsedCarElements: [manufacturer])
        XCTAssertEqual(sut.elementsCount, 1)
        sut.removeAllCarElemnts()
        XCTAssertEqual(sut.elementsCount, 0)
    }

    func testFetchAdditionalCarElemets_CallscallAPI() {
        sut.fetchAdditionalCarElemets(for: 1)
        XCTAssertTrue((mockAPIClient?.callAPIGotCalled)!)
    }
    
}

extension ManufacturerManagerTests {

    class MockAPIClient: APIClient {

        var callAPIGotCalled = false
        override func callAPI(with url: URL, completion: @escaping ([String : AnyObject]?, Error?) -> Void) {
            self.callAPIGotCalled = true
        }

    }
}






