//
//  ModelsParser.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ModelsParser: IParser {

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) -> [ICarElement] {
        guard let carElementsDict = carElementsDict else { fatalError() }
        guard let modelsDict = carElementsDict[GlobalConstants.ParserKey] as? [String: String] else { fatalError() }
        var models = [Model]()
        for (_, name) in modelsDict {
            let model = Model(name: name)
            models.append(model)
        }
        return sortedByName(models: models)
    }

    private func sortedByName(models: [Model]) -> [Model] {
        return models.sorted { $0.name < $1.name }
    }

}
