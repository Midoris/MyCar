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
        let notificationName = Notification.Name("ManufacturersParsingCompleted")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
    }
    
}
