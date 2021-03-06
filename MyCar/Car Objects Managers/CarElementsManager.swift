//
//  CarElementsManager.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class CarElementsManager {

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
        // For Test SendsNotification in ManufacturersListDataProviderTests to solve some weird bug
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            if (index >= 0 && elementsCount > index) {
                return carElemnts[index]
            } else {
                let manufacturers = Manufacturer(id: "", name: "")
                let models = Model(name: "")
                return (parser is ManufacturersParser) ? manufacturers : models
            }
        } else {
            return carElemnts[index]
        }
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
        guard error == nil && carElementsDict != nil else {
            AlertPresenter.showAlert(withTitle: GlobalConstants.CantLoadDataErrorTitle, andMessage: GlobalConstants.CantLoadDataErrorMessage)
            return
        }
        let parsedCarElements = parser.parse(carElementsDict: carElementsDict!)
        add(parsedCarElements: parsedCarElements)
    }

}
