//
//  Manager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class Manager {

    private var parser: IParser
    private var notificator: IParsingCompletionNotificator
    private var carElemnts = [ICarElement]()
    var elementsCount: Int { return carElemnts.count }

    let apiClient = APIClient()

    init(parser: IParser, notificator: IParsingCompletionNotificator) {
        self.parser = parser
        self.notificator = notificator
    }

    func add(carElement: ICarElement) {
        carElemnts.append(carElement)
    }

    func carElement(at index: Int) -> ICarElement {
        return carElemnts[index]
    }

    func removeAllCarElemnts() {
        carElemnts.removeAll()
    }

    func fetchCarElemets() {
        let url = URL(string: "http://api.wkda-test.com/v1/car-types/manufacturer?page=0&pageSize=15&wa_key=coding-puzzle-client-449cc9d")
        apiClient.callAPI(with: url!, completion: self.parse)
    }

    func fetchCarElemets(for page: Int) {
        let url = URL(string: "http://api.wkda-test.com/v1/car-types/manufacturer?page=\(page)&pageSize=15&wa_key=coding-puzzle-client-449cc9d")
        apiClient.callAPI(with: url!, completion: self.parse)
    }

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) {
        let careElements = parser.parse(carElementsDict: carElementsDict, error: error)
        self.carElemnts += careElements
        notificator.notifyParsingCompletion()
    }
    
}
