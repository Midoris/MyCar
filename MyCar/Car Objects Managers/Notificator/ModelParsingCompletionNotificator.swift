//
//  ModelParsingCompletionNotificator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ModelParsingCompletionNotificator: IParsingCompletionNotificator {

    func notifyParsingCompletion() {
        DispatchQueue.main.async {
            self.postNotification()
        }
    }

    private func postNotification() {
        let notificationName = Notification.Name(GlobalConstants.ModelsParsingCompletedNotificationID)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
    }
    
}
