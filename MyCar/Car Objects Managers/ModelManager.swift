//
//  ModelManager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ModelManager {

    var modelsCount: Int { return models.count }
    private var models = [Model]()

    func add(model: Model) {
        models.append(model)
    }

    func model(at index: Int) -> Model {
        return models[index]
    }

    func removeAllModels() {
        models.removeAll()
    }
    
}
