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

        setUpDependencies()
        setUpNotification()
        manufacturerManager?.fetchCarElemets()
    }

    func setUpDependencies() {
        let manufacturersParser = ManufacturersParser()
        let manufacturerURLGenerator = ManufacturerURLGenerator()
        let apiClient = APIClient()
        manufacturerManager = CarElementManager(parser: manufacturersParser, notificator: parsingCompletionNotificator, urlGenerator: manufacturerURLGenerator, apiClient: apiClient)
        manufacturersListDataProvider = ListDataProvider(manager: manufacturerManager!, notificator: cellSelectionNotificator)
        manufacturersTableView.dataSource = manufacturersListDataProvider
        manufacturersTableView.delegate = manufacturersListDataProvider
    }

    func setUpNotification() {
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
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: GlobalConstants.ModelsListVCID) as? ModelsListViewController {
            nextViewController.selectedManufacturer = selectedManufacturer
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }


}
