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

    func testCellRorRow_ReturnsManufacturerCell() {
        sut.manufacturerManager?.add(manufacturer: Manufacturer(id: "101", name: "BMW"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ManufacturerCell)
    }

    func testCellForRow_DequesCell() {
        let mockTableView = MockTableView.mockTableView(with: sut)
        sut.manufacturerManager?.add(manufacturer: Manufacturer(id: "101", name: "NMW"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequed)
    }

    func testConfigCell_GetsCalledInCellForRow() {
        let mockTableView = MockTableView.mockTableView(with: sut)
        let manufacturer = Manufacturer(id: "070", name: "Audi")
        sut.manufacturerManager?.add(manufacturer: manufacturer)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockManufacturerCell
        XCTAssertEqual(cell.manufacturer?.id, manufacturer.id)
        XCTAssertEqual(cell.manufacturer?.name, manufacturer.name)
    }

    func testSelectionCell_SendsNotification() {
        let manufacturer = Manufacturer(id: "070", name: "Audi")
        sut.manufacturerManager?.add(manufacturer: manufacturer)
        expectation(forNotification: "ManufacturerSelectedNotification", object: nil) { (notification) -> Bool in
            guard let index = notification.userInfo?["index"] as? Int else {
                return false
            }
            return index == 0
        }
        tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}


extension ManufacturersListDataProviderTests {

    class MockTableView: UITableView {

        var cellGotDequed = false

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequed = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }

        class func mockTableView(with dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockManufacturerCell.self, forCellReuseIdentifier: "ManufacturerCell")
            return mockTableView
        }
    }

    class MockManufacturerCell: ManufacturerCell {

        var manufacturer: Manufacturer?

        override func configCell(with manufacturer: Manufacturer) {
            self.manufacturer = manufacturer
        }
    }
}

