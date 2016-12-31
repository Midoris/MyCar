//
//  APIClient.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 29/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation

class APIClient: IAPICLient {

    lazy var session: ICarURLSession = URLSession.shared

    func callAPI(with url: URL, completion: @escaping ([String: AnyObject]?, Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, responss, error) in
            if error != nil {
                completion(nil, WebServiceError.responseError)
                return
            }
            if let theData = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: theData, options: [])
                    if let responseDict = jsonObject as? [String: AnyObject] {
                        completion(responseDict, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, WebServiceError.dataEmptyError)
            }
        }
        task.resume()
    }

}

enum WebServiceError: Error {
    case dataEmptyError
    case responseError
}

protocol ICarURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: ICarURLSession {
}
