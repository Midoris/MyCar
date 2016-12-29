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
    var manufacturerManager: Manager!
    var manufacturersListDataProvider: ListDataProvider?
    let notificator = CellSelectionNotificator(notificationId: "ManufacturerCellSelected")

    override func viewDidLoad() {
        super.viewDidLoad()
        let manufacturersParser = ManufacturersParser()

        
        manufacturerManager = Manager(parser: manufacturersParser)
        manufacturersListDataProvider = ListDataProvider(manager: self.manufacturerManager, notificator: notificator)


        manufacturersTableView.dataSource = manufacturersListDataProvider
        manufacturersTableView.delegate = manufacturersListDataProvider

        manufacturerManager?.fetchCarElemets()
    }

}
