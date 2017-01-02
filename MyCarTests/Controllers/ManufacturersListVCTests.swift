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
        sut = storyBoard.instantiateViewController(withIdentifier: GlobalConstants.ManufacturersListVCID) as! ManufacturersListViewController
        _ = sut.view
    }

    override func tearDown() {
        sut.manufacturerManager.removeAllCarElemnts()
        sut.manufacturerManager = nil
        NotificationCenter.default.removeObserver(sut)
        super.tearDown()
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.manufacturersTableView)
    }

    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.manufacturersTableView.dataSource)
        XCTAssertTrue(sut.manufacturersTableView.dataSource is ListDataProvider)
    }

    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.manufacturersTableView.delegate)
        XCTAssertTrue(sut.manufacturersTableView.delegate is ListDataProvider)
    }

    func testViewDidLoad_ShouldSetDelegateAndDataSourceToSameObject() {
        XCTAssertEqual(sut.manufacturersTableView.delegate as? ListDataProvider, sut.manufacturersTableView.dataSource as? ListDataProvider)
    }

    func testViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.manufacturerManager === sut.manufacturersListDataProvider?.manager)
    }

    func testCellSelectedNotification_PushesModelsListVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        _ = sut.view
        let notificationName = Notification.Name(GlobalConstants.ManufacturerCellSelectedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["index" : 0])
        guard let modelsListVC = mockNavigationController.pushedVIewController as? ModelsListViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(modelsListVC.selectedManufacturer)
    }

}

extension ManufacturersListVCTests {

    class MockNavigationController: UINavigationController {

        var pushedVIewController: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedVIewController = viewController
            super.pushViewController(viewController, animated: animated)

        }
    }
}

