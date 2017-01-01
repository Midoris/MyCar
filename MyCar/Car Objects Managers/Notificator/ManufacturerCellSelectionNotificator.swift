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
        DispatchQueue.main.async {
            self.postNotification(with: index)
        }
    }

    private func postNotification(with num: Int) {
        let notificationName = Notification.Name(GlobalConstants.ManufacturerCellSelectedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: [GlobalConstants.NotificationUserInfoKey: num])
    }

}

