//
//  GlobalConstants.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

struct GlobalConstants {

    static let ManufacturerCellSelectedNotificationID = "ManufacturerCellSelected"
    static let ManufacturersParsingCompletedNotificationID = "ManufacturersParsingCompleted"
    static let ModelCellSelectedNotificationID = "ModelCellSelected"
    static let ModelsParsingCompletedNotificationID = "ModelsParsingCompleted"

    static let ManufacturersListVCID = "ManufacturersListViewController"
    static let ModelsListVCID = "ModelsListViewController"
    static let CarVCID = "CarViewController"

    static let ICarElementCellID = "ICarElementCell"

    static let ParserKey = "wkda"
    static let NotificationUserInfoKey = "index"

    static let CantLoadDataErrorTitle = "Ops"
    static let CantLoadDataErrorMessage = "Sorry, we could not load the data"
}
