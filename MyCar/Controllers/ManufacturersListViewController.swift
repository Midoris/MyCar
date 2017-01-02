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
    var manufacturerManager: CarElementsManager!
    var manufacturersListDataProvider: ListDataProvider!
    let cellSelectionNotificator = ManufacturerCellSelectionNotificator()
    let parsingCompletionNotificator = ManufacturerParsingCompletionNotificator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDependencies()
        setUpNotifications()
        manufacturerManager.fetchCarElemets()
    }

    func setUpDependencies() {
        let manufacturersParser = ManufacturersParser()
        let manufacturerURLGenerator = ManufacturerURLGenerator()
        let apiClient = APIClient()
        let paganator = Paganator()
        manufacturerManager = CarElementsManager(parser: manufacturersParser, notificator: parsingCompletionNotificator, urlGenerator: manufacturerURLGenerator, apiClient: apiClient)
        manufacturersListDataProvider = ListDataProvider(manager: manufacturerManager, notificator: cellSelectionNotificator, paganator: paganator)
        manufacturersTableView.dataSource = manufacturersListDataProvider
        manufacturersTableView.delegate = manufacturersListDataProvider
    }

    func setUpNotifications() {
        let parsingNotificationName = Notification.Name(GlobalConstants.ManufacturersParsingCompletedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ManufacturersListViewController.updateUI), name: parsingNotificationName, object: nil)
        let selctionNotificationName = Notification.Name(GlobalConstants.ManufacturerCellSelectedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ManufacturersListViewController.manufacturerSelected(sender:)), name: selctionNotificationName, object: nil)
    }

    func updateUI() {
        self.manufacturersTableView.reloadData()
    }

    func manufacturerSelected(sender: Notification) {
        guard let index = sender.userInfo?[GlobalConstants.NotificationUserInfoKey] as? Int else {
            fatalError()
        }
        let selectedManufacturer = manufacturerManager?.carElement(at: index)
        openModelsListVC(with: selectedManufacturer as! Manufacturer)
    }

    func openModelsListVC(with selectedManufacturer: Manufacturer) {
        if let modelVC = storyboard?.instantiateViewController(withIdentifier: GlobalConstants.ModelsListVCID) as? ModelsListViewController {
            modelVC.selectedManufacturer = selectedManufacturer
            navigationController?.pushViewController(modelVC, animated: true)
        }
    }


}
