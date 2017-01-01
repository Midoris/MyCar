//
//  ModelCellSelectionNotificator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ModelCellSelectionNotificator: ICellSelectionNotificator {

    func notifyCellSelection(at index: Int) {
        DispatchQueue.main.async {
            self.postNotification(with: index)
        }
    }

    private func postNotification(with num: Int) {
        let notificationName = Notification.Name(GlobalConstants.ModelCellSelectedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: [GlobalConstants.NotificationUserInfoKey: num])
    }
    
}
