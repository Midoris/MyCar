//
//  ManufacturersListVCTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ManufacturersListVCTests: XCTestCase {
    
    var sut: ManufacturersListViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: "ManufacturersListViewController") as! ManufacturersListViewController
        _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.manufacturersTableView)
    }

    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.manufacturersTableView.dataSource)
        XCTAssertTrue(sut.manufacturersTableView.dataSource is ManufacturersListDataProvider)
    }

    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.manufacturersTableView.delegate)
        XCTAssertTrue(sut.manufacturersTableView.delegate is ManufacturersListDataProvider)
    }

    func testViewDidLoad_ShouldSetDelegateAndDataSourceToSameObject() {
        XCTAssertEqual(sut.manufacturersTableView.delegate as? ManufacturersListDataProvider, sut.manufacturersTableView.dataSource as? ManufacturersListDataProvider)
    }

    func testViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.manufacturerManager === sut.manufacturersListDataProvider.manufacturerManager)
    }



}
