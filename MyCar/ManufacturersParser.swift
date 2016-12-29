//
//  ManufacturersParser.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ManufacturersParser: Parser {

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) -> [CarElement] {
        guard let carElementsDict = carElementsDict else { fatalError() }
        guard let manufacturersDict = carElementsDict["wkda"] as? [String: String] else { fatalError() }
        var manufacturers = [Manufacturer]()
        for(id, name) in manufacturersDict {
            let manufacturer = Manufacturer(id: id, name: name)
            manufacturers.append(manufacturer)
        }
        return manufacturers
    }
}
