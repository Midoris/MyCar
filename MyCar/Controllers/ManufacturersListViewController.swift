//
//  ManufacturersListViewController.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class ManufacturersListViewController: UIViewController {
    
    @IBOutlet weak var manufacturersTableView: UITableView!
    var manufacturerManager: CarElementManager?
    var manufacturersListDataProvider: ListDataProvider?
    let cellSelectionNotificator = ManufacturerCellSelectionNotificator()
    let parsingCompletionNotificator = ManufacturerParsingCompletionNotificator()

    override func viewDidLoad() {
        super.viewDidLoad()
        let manufacturersParser = ManufacturersParser()

        let manufacturerURLGenerator = ManufacturerURLGenerator()
        let apiClient = APIClient()
        manufacturerManager = CarElementManager(parser: manufacturersParser, notificator: parsingCompletionNotificator, urlGenerator: manufacturerURLGenerator, apiClient: apiClient)
        manufacturersListDataProvider = ListDataProvider(manager: manufacturerManager!, notificator: cellSelectionNotificator)


        manufacturersTableView.dataSource = manufacturersListDataProvider
        manufacturersTableView.delegate = manufacturersListDataProvider

        setUpNotification()
        manufacturerManager?.fetchCarElemets()


    }

    func updateUI() {
        DispatchQueue.main.async {
            self.manufacturersTableView.reloadData()
        }
    }

    func manufacturerSelected(sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int else {
            fatalError()
        }
        //let selectedManufacturer = manufacturerManager.carElement(at: index)
        //print("selectedManufacturer is \(selectedManufacturer)")
    }

    func setUpNotification() {
        let parsingnotificationName = Notification.Name(GlobalConstants.ManufacturersParsingCompletedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ManufacturersListViewController.updateUI), name: parsingnotificationName, object: nil)
        let selctionNotificationName = Notification.Name(GlobalConstants.ManufacturerCellSelectedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ManufacturersListViewController.manufacturerSelected(sender:)), name: selctionNotificationName, object: nil)
    }

}
