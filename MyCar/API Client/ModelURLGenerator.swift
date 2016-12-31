//
//  URLGenerator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class ModelURLGenerator: IURLGenerator {

    private var manufacturerID: String

    init(manufacturerID: String) {
        self.manufacturerID = manufacturerID
    }

    func urlForFirstPage() throws -> URL {
        let url = URL(string: "\(URLElementsConstsnts.BaseURL)/v1/car-types/main-types?manufacturer=\(manufacturerID)&page=0&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
        guard url != nil else { throw URLGeneratorError.notAbleGenerateURL }
        return url!
    }

    func urlFor(page number: Int) throws -> URL {
        let url = URL(string: "\(URLElementsConstsnts.BaseURL)/v1/car-types/main-types?manufacturer=\(manufacturerID)&page\(number)&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
        guard url != nil else { throw URLGeneratorError.notAbleGenerateURL }
        return url!
    }

}
