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

    var manager: CarElementManager?
    var notificator: ICellSelectionNotificator?

    private var loadingCellNamber: Int {
        return manager!.elementsCount - 1
    }
    private var pageNumber = 1
    private var oldLoadingNumber = 0

    init(manager: CarElementManager, notificator: ICellSelectionNotificator) {
        self.manager = manager
        self.notificator = notificator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager?.elementsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ICarElementCell", for: indexPath) as! ICarElementCell
        guard let manager = manager else { fatalError() }
        let carElement = manager.carElement(at: indexPath.row)
        cell.configCell(with: carElement, for: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notificator?.notifyCellSelection(at: indexPath.row)
    }


    var nextLoadingPoint: Int {
        return (manager?.elementsCount)! - 3
    }
    var lastLoadingPoint = 0
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if nextLoadingPoint > lastLoadingPoint {
            if indexPath.row == nextLoadingPoint {
                manager?.fetchAdditionalCarElemets(for: pageNumber)
                lastLoadingPoint = nextLoadingPoint
                pageNumber += 1
            }
        }


    }


}

