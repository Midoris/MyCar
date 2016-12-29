//
//  ManufacturerCellSelectionNotificator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ManufacturerCellSelectionNotificator: ICellSelectionNotificator {

    func notifyCellSelection(at index: Int) {
        let notificationName = Notification.Name("ManufacturerCellSelected")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["index" : index])
    }

}

