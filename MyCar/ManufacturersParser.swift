//
//  ManufacturersParser.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ManufacturersParser: IParser {

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) -> [ICarElement] {
        guard let carElementsDict = carElementsDict else { fatalError() }
        guard let manufacturersDict = carElementsDict[GlobalConstants.ParserKey] as? [String: String] else { fatalError() }
        var manufacturers = [Manufacturer]()
        for (id, name) in manufacturersDict {
            let manufacturer = Manufacturer(id: id, name: name)
            manufacturers.append(manufacturer)
        }
        return sortedByName(manufacturers: manufacturers)
    }

    private func sortedByName(manufacturers: [Manufacturer]) -> [Manufacturer] {
        return manufacturers.sorted { $0.name < $1.name }
    }
    
}
