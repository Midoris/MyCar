//
//  Manager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class Manager {

    var elementsCount: Int { return carElemnts.count }
    private var carElemnts = [CarElement]()

    func add(carElement: CarElement) {
        carElemnts.append(carElement)
    }

    func carElement(at index: Int) -> CarElement {
        return carElemnts[index]
    }

    func removeAllCarElemnts() {
        carElemnts.removeAll()
    }
    
}
