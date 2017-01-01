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
        self.title = selectedManufacturer?.name
        setUpDependencies()
        setUpNotification()
        modelManager?.fetchCarElemets()
    }

    func setUpDependencies() {
        let modelsParser = ModelsParser()
        guard let selectedManufacturerID = selectedManufacturer?.id else { fatalError() }
        let modelURLGenerator = ModelURLGenerator(manufacturerID: selectedManufacturerID)
        let apiClient = APIClient()
        modelManager = CarElementManager(parser: modelsParser, notificator: parsingCompletionNotificator, urlGenerator: modelURLGenerator, apiClient: apiClient)
        modelsListDataProvider = ListDataProvider(manager: modelManager!, notificator: cellSelectionNotificator)
        modelsTableView.dataSource = modelsListDataProvider
        modelsTableView.delegate = modelsListDataProvider
    }

    func setUpNotification() {
        let parsingNotificationName = Notification.Name(GlobalConstants.ModelsParsingCompletedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ModelsListViewController.updateUI), name: parsingNotificationName, object: nil)
        let selctionNotificationName = Notification.Name(GlobalConstants.ModelCellSelectedNotificationID)
        NotificationCenter.default.addObserver(self, selector: #selector(ModelsListViewController.modelSelected(sender:)), name: selctionNotificationName, object: nil)
    }

    func updateUI() {
        self.modelsTableView.reloadData()
    }

    func modelSelected(sender: Notification) {
        guard let index = sender.userInfo?[GlobalConstants.NotificationUserInfoKey] as? Int else {
            fatalError()
        }
        let selectedModel = modelManager?.carElement(at: index) as! Model
        openCarVC(with: selectedModel)
    }

    func openCarVC(with selectedModel: Model) {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: GlobalConstants.CarVCID) as? CarViewController {
            nextViewController.car = Car(manufacturer: selectedManufacturer!, model: selectedModel)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }




}
