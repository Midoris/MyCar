//
//  ParsingCompletionNotificator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ParsingCompletionNotificator {

    private var notificationId: String

    init(notificationId: String) {
        self.notificationId = notificationId
    }

    func notifyParsingCompletion() {
        let notificationName = Notification.Name(notificationId)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
    }
    
}
