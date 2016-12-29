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
    private var urlGenerator: IURLGenerator
    private var carElemnts = [ICarElement]()
    var elementsCount: Int { return carElemnts.count }

    let apiClient = APIClient()

    init(parser: IParser, notificator: IParsingCompletionNotificator, urlGenerator: IURLGenerator) {
        self.parser = parser
        self.notificator = notificator
        self.urlGenerator = urlGenerator
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
        var url: URL
        do {
            try url = urlGenerator.urlForFirstPage()
            apiClient.callAPI(with: url, completion: self.parse)
        } catch {
            // do something with error
            print("ERROR is \(error.localizedDescription)")
        }
    }

    func fetchAdditionalCarElemets(for page: Int) {
        var url: URL
        do {
            try url = urlGenerator.urlFor(page: page)
            apiClient.callAPI(with: url, completion: self.parse)
        } catch {
            // do something with error
            print("ERROR is \(error.localizedDescription)")
        }
    }

    func parse(carElementsDict: [String : AnyObject]?, error: Error?) {
        let careElements = parser.parse(carElementsDict: carElementsDict, error: error)
        self.carElemnts += careElements
        notificator.notifyParsingCompletion()
    }
    
}
