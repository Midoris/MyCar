//
//  ManufacturerParsingCompletionNotificator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ManufacturerParsingCompletionNotificator: IParsingCompletionNotificator {

    func notifyParsingCompletion() {
        DispatchQueue.main.async {
            self.postNotification()
        }
    }

    private func postNotification() {
        let notificationName = Notification.Name(GlobalConstants.ManufacturersParsingCompletedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
    }
    
}
