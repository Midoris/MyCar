//
//  ManufacturersListDataProviderTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ManufacturersListDataProviderTests: XCTestCase {
    
    var sut: ManufacturersListDataProvider!
    var tableView: UITableView!
    var controller: ManufacturersListViewController!

    override func setUp() {
        super.setUp()
        sut = ManufacturersListDataProvider()
        sut.manufacturerManager = ManufacturerManager()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(withIdentifier: "ManufacturersListViewController") as! ManufacturersListViewController
        _ = controller.view
        tableView = controller.manufacturersTableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        sut.manufacturerManager?.removeAllManufacturers()
        sut.manufacturerManager = nil
        super.tearDown()
    }

    func testNumberOfRows_InitiallyIsZero() {
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    }

    func testNumberOfRows_ShouldBeManufacturers() {
        sut.manufacturerManager?.add(manufacturer: Manufacturer(id: "101", name: "BMW"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.manufacturerManager?.manufacturersCount)
        sut.manufacturerManager?.add(manufacturer: Manufacturer(id: "070", name: "Audi"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.manufacturerManager?.manufacturersCount)
    }

    
}
