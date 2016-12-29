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

    let manufacturerManager = Manager()
    let manufacturersListDataProvider = ListDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        manufacturersTableView.dataSource = manufacturersListDataProvider
        manufacturersTableView.delegate = manufacturersListDataProvider
        manufacturersListDataProvider.manager = self.manufacturerManager
    }


}
