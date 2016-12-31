//
//  Manager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class CarElementManager {

    private var parser: IParser
    private var notificator: IParsingCompletionNotificator
    private var urlGenerator: IURLGenerator
    private var apiClient: IAPICLient
    private var carElemnts = [ICarElement]()
    var elementsCount: Int { return carElemnts.count }

    init(parser: IParser, notificator: IParsingCompletionNotificator, urlGenerator: IURLGenerator, apiClient: IAPICLient) {
        self.parser = parser
        self.notificator = notificator
        self.urlGenerator = urlGenerator
        self.apiClient = apiClient
    }

    func carElement(at index: Int) -> ICarElement {
        return carElemnts[index]
    }

    func add(parsedCarElements: [ICarElement]) {
        self.carElemnts += parsedCarElements
        notificator.notifyParsingCompletion()
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
        let parsedCarElements = parser.parse(carElementsDict: carElementsDict, error: error)
        add(parsedCarElements: parsedCarElements)
    }

}
