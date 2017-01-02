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
    
    var sut: ListDataProvider!
    var tableView: UITableView!
    var controller: ManufacturersListViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(withIdentifier: "ManufacturersListViewController") as! ManufacturersListViewController
        _ = controller.view
        sut = controller.manufacturersListDataProvider
        sut.manager = controller.manufacturerManager
        tableView = controller.manufacturersTableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        sut.manager.removeAllCarElemnts()
        super.tearDown()
    }

    func testNumberOfRows_InitiallyIsZero() {
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    }

    func testNumberOfRows_ShouldBeManufacturers() {
        sut.manager.add(parsedCarElements: [Manufacturer(id: "101", name: "BMW")])
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.manager.elementsCount)
        sut.manager.add(parsedCarElements: [Manufacturer(id: "070", name: "Audi")])
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), sut.manager.elementsCount)
    }

    func testCellRorRow_ReturnsManufacturerCell() {
        sut.manager.add(parsedCarElements: [Manufacturer(id: "101", name: "BMW")])
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ICarElementCell)
    }

    func testCellForRow_DequesCell() {
        let mockTableView = MockTableView.mockTableView(with: sut)
        sut.manager.add(parsedCarElements: [Manufacturer(id: "101", name: "NMW")])
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequed)
    }

    func testConfigCell_GetsCalledInCellForRow() {
        NotificationCenter.default.removeObserver(controller)
        let mockTableView = MockTableView.mockTableView(with: sut)
        let manufacturer = Manufacturer(id: "070", name: "Audi")
        sut.manager.add(parsedCarElements: [manufacturer])
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockICarElementCell
        XCTAssertEqual(cell.manufacturer?.id, manufacturer.id)
        XCTAssertEqual(cell.manufacturer?.name, manufacturer.name)
    }

    func testSelectionCellNotification_SendsNotification() {
        let manufacturer = Manufacturer(id: "070", name: "Audi")
        sut.manager.add(parsedCarElements: [manufacturer])
        expectation(forNotification: GlobalConstants.ManufacturerCellSelectedNotificationID, object: nil) { (notification) -> Bool in
            guard let index = notification.userInfo?[GlobalConstants.NotificationUserInfoKey] as? Int else {
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
            mockTableView.register(MockICarElementCell.self, forCellReuseIdentifier: "ICarElementCell")
            return mockTableView
        }
    }

    class MockICarElementCell: ICarElementCell {

        var manufacturer: Manufacturer?

        override func configCell(with carElement: ICarElement, for index: Int) {
            self.manufacturer = carElement as? Manufacturer
        }
    }

}

