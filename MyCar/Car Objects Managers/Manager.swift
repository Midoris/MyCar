//
//  Manager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class Manager {

    private var parser: Parser
    private var notificator: ParsingCompletionNotificator
    private var carElemnts = [CarElement]()
    var elementsCount: Int { return carElemnts.count }

    init(parser: Parser, notificator: ParsingCompletionNotificator) {
        self.parser = parser
        self.notificator = notificator
    }

    func add(carElement: CarElement) {
        carElemnts.append(carElement)
    }

    func carElement(at index: Int) -> CarElement {
        return carElemnts[index]
    }

    func removeAllCarElemnts() {
        carElemnts.removeAll()
    }

    func fetchCarElemets() {
        let apiClient = APIClient()
        let url = URL(string: "http://api.wkda-test.com/v1/car-types/manufacturer?page=0&pageSize=15&wa_key=coding-puzzle-client-449cc9d")
        apiClient.callAPI(with: url!, completion: self.parse)
    }

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) {
        let careElements = parser.parse(carElementsDict: carElementsDict, error: error)
        self.carElemnts += careElements
        notificator.notifyParsingCompletion()
    }
    
}
