//
//  ManufacturersListDataProvider.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation
import UIKit

class ManufacturersListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

    var manufacturerManager: ManufacturerManager?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturerManager?.manufacturersCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
