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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManufacturerCell", for: indexPath) as! ManufacturerCell
        guard let manufacturerManager = manufacturerManager else { fatalError() }
        let manufacturer = manufacturerManager.manufacturer(at: indexPath.row)
        cell.configCell(with: manufacturer)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationName = Notification.Name("ManufacturerSelectedNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["index" : indexPath.row])
    }
}
