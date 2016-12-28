//
//  ManufacturerManager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ManufacturerManager {

    var manufacturersCount: Int { return manufacturers.count }
    private var manufacturers = [Manufacturer]()

    func add(manufacturer: Manufacturer) {
        manufacturers.append(manufacturer)
    }

    func manufacturer(at index: Int) -> Manufacturer {
        return manufacturers[index]
    }

    func removeAllManufacturers() {
        manufacturers.removeAll()
    }

}
