//
//  ManufacturerCellTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ManufacturerCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSUT_HasNameLabel() {
        let cell = dequeuedManufacturerCell(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell.iCarElementNameLabel)
    }

    func testConfigWithManufacturer_SetsNameLabelText() {
        let cell = dequeuedManufacturerCell(for: IndexPath(row: 0, section: 0))
        cell.configCell(with: Manufacturer(id: "101", name: "BMW"), for: 0)
        XCTAssertEqual(cell.iCarElementNameLabel.text, "BMW")
    }

    func dequeuedManufacturerCell(for indexPath: IndexPath) -> ICarElementCell {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "ManufacturersListViewController") as! ManufacturersListViewController
        _ = controller.view
        let tableView = controller.manufacturersTableView
        let dataProvider = FakeDataSource()
        tableView?.dataSource = dataProvider
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ICarElementCell", for: indexPath) as! ICarElementCell
        return cell
    }


}

extension ManufacturerCellTests {

    class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
    }
}
