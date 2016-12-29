//
//  URLGenerator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class URLGenerator {

    class func urlForFirstPage() throws -> URL {
        let url = URL(string: "http://api.wkda-test.com/v1/car-types/manufacturer?page=0&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
        guard url != nil else { throw URLGeneratorError.notAbleGenerateURl }
        return url!
    }

    class func urlFor(page number: Int) throws -> URL {
        let url = URL(string: "http://api.wkda-test.com/v1/car-types/manufacturer?page=\(number)&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
        guard url != nil else { throw URLGeneratorError.notAbleGenerateURl }
        return url!
    }
}

enum URLGeneratorError: Error {
    case notAbleGenerateURl
}
