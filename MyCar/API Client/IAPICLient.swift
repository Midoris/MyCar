//
//  IAPICLient.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 30/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

protocol IAPICLient {
    var session: ICarURLSession { get set }
    func callAPI(with url: URL, completion: @escaping ([String: AnyObject]?, Error?) -> Void)
}
