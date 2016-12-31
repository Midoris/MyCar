//
//  IURLGenerator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

protocol IURLGenerator {
    func urlForFirstPage() throws -> URL
    func urlFor(page number: Int) throws -> URL
}

enum URLGeneratorError: Error {
    case notAbleGenerateURL
}
