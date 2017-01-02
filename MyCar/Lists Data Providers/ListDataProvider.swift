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

    var manager: CarElementsManager
    private var notificator: ICellSelectionNotificator
    private let paganator: IPaganator

    init(manager: CarElementsManager, notificator: ICellSelectionNotificator, paganator: IPaganator) {
        self.manager = manager
        self.notificator = notificator
        self.paganator = paganator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.elementsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConstants.ICarElementCellID, for: indexPath) as! ICarElementCell
        let carElement = manager.carElement(at: indexPath.row)
        cell.configCell(with: carElement, for: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notificator.notifyCellSelection(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        paganator.performPagination(for: indexPath.row, using: manager.fetchAdditionalCarElemets, elementsCount: manager.elementsCount)
    }

}





