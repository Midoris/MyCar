//
//  ListDataProvider.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation
import UIKit

class ListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

    var manager: Manager?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager?.elementsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManufacturerCell", for: indexPath) as! ManufacturerCell
        guard let manager = manager else { fatalError() }
        let carElement = manager.carElement(at: indexPath.row)
        cell.configCell(with: carElement)
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationName = Notification.Name("ManufacturerSelectedNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["index" : indexPath.row])
    }
}
