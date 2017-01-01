//
//  ModelsListViewController.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class ModelsListViewController: UIViewController {

    var selectedManufacturer: Manufacturer?
    @IBOutlet weak var modelsTableView: UITableView!
    var modelManager: CarElementManager?
    var modelsListDataProvider: ListDataProvider?
    let cellSelectionNotificator = ModelCellSelectionNotificator()
    let parsingCompletionNotificator = ModelParsingCompletionNotificator()


    override func viewDidLoad() {
        super.viewDidLoad()


        let modelsParser = ModelsParser()
        guard let selectedManufacturerID = selectedManufacturer?.id else { fatalError() }
        let modelURLGenerator = ModelURLGenerator(manufacturerID: selectedManufacturerID)
        let apiClient = APIClient()
        modelManager = CarElementManager(parser: modelsParser, notificator: parsingCompletionNotificator, urlGenerator: modelURLGenerator, apiClient: apiClient)
        modelsListDataProvider = ListDataProvider(manager: modelManager!, notificator: cellSelectionNotificator)


        modelsTableView.dataSource = modelsListDataProvider
        modelsTableView.delegate = modelsListDataProvider

        setUpNotification()
        modelManager?.fetchCarElemets()

    }

    func setUpNotification() {
        let parsingNotificationName = Notification.Name(GlobalConstants.ModelsParsingCompletedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ModelsListViewController.updateUI), name: parsingNotificationName, object: nil)
        let selctionNotificationName = Notification.Name(GlobalConstants.ModelCellSelectedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ModelsListViewController.modelSelected(sender:)), name: selctionNotificationName, object: nil)
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.modelsTableView.reloadData()
        }
    }

    func modelSelected(sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int else {
            fatalError()
        }
        //let selectedManufacturer = manufacturerManager.carElement(at: index)
        //print("selectedManufacturer is \(selectedManufacturer)")
    }



    

}
