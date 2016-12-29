//
//  Parser.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

protocol Parser {
    func parse(carElementsDict: [String: AnyObject]?, error: Error?) -> [CarElement]
}
