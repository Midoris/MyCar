//
//  ModelsListVCTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class ModelsListVCTests: XCTestCase {
    
    var sut: ModelsListViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: GlobalConstants.ModelsListVCID) as! ModelsListViewController
        sut.selectedManufacturer = Manufacturer(id: "101", name: "BMW")
        _ = sut.view
    }

    override func tearDown() {
        NotificationCenter.default.removeObserver(sut)
        sut.modelManager.removeAllCarElemnts()
        sut.modelManager = nil
        super.tearDown()
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.modelsTableView)
    }

    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.modelsTableView.dataSource)
        XCTAssertTrue(sut.modelsTableView.dataSource is ListDataProvider)
    }

    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.modelsTableView.delegate)
        XCTAssertTrue(sut.modelsTableView.delegate is ListDataProvider)
    }

    func testViewDidLoad_ShouldSetDelegateAndDataSourceToSameObject() {
        XCTAssertEqual(sut.modelsTableView.delegate as? ListDataProvider, sut.modelsTableView.dataSource as? ListDataProvider)
    }

    func testViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.modelManager === sut.modelsListDataProvider?.manager)
    }
    
    func testOpenCarVC_PushesCarVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        _ = sut.view
        let model = Model(name: "Audi")
        sut.openCarVC(with: model)
        XCTAssertTrue(mockNavigationController.pushedVIewController is CarViewController)
        let carVC = mockNavigationController.pushedVIewController as! CarViewController
        XCTAssertEqual(carVC.car.model.name, model.name)
    }

    func testModelCellSelectedNotification_PushesCarVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        _ = sut.view
        let model = Model(name: "Audi")
        sut.modelManager.add(parsedCarElements: [model])
        expectation(forNotification: GlobalConstants.ModelCellSelectedNotificationID, object: nil) { (notification) -> Bool in
            guard let index = notification.userInfo?[GlobalConstants.NotificationUserInfoKey] as? Int else {
                return false
            }
            return index == 0
        }
        let notificationName = Notification.Name(GlobalConstants.ModelCellSelectedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: [GlobalConstants.NotificationUserInfoKey: 0])
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(mockNavigationController.pushedVIewController is CarViewController)
    }

    
}

extension ModelsListVCTests {

    class MockNavigationController: UINavigationController {

        var pushedVIewController: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedVIewController = viewController
            super.pushViewController(viewController, animated: animated)
            
        }
    }
}







