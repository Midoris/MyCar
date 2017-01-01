//
//  Paganator.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class Paganator {

    private var pageNumber = 0
    private var previousLoadingIndex = 0
    private let beforehandNumber = 3

    func performPagination(for row: Int, using fetchMethod: (_: Int) -> (), elementsCount: Int) {
        let nextLoadingIndex = elementsCount - beforehandNumber
        if nextLoadingIndex > previousLoadingIndex {
            if row == nextLoadingIndex {
                previousLoadingIndex = nextLoadingIndex
                pageNumber += 1
                fetchMethod(pageNumber)
            }
        }
    }
    
}
