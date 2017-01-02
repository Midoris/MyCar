//
//  APIClientTests.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 02/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import MyCar

class APIClientTests: XCTestCase {

    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCallAPI_MakesRequestWithExpectedPageSizeAndKey() {
        let completion = { (carElementsDict: [String : AnyObject]?, error: Error?) in }
        let urlGenerator = ManufacturerURLGenerator()
        let url = try? urlGenerator.urlForFirstPage()
        XCTAssertNotNil(url)
        sut.callAPI(with: url!, completion: completion)
        XCTAssertNotNil(mockURLSession.completionHendler)
        guard let sessionUrl = mockURLSession.url else {
            fatalError()
        }
        let urlsComponents = URLComponents(url: sessionUrl, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlsComponents?.percentEncodedQuery, "page=0&pageSize=\(URLElementsConstsnts.PageSize)&wa_key=\(URLElementsConstsnts.Key)")
    }

    func testCallAPI_CallsResumeOfDataTask() {
        sut.session = mockURLSession
        let completion = { (carElementsDict: [String : AnyObject]?, error: Error?) in }
        let urlGenerator = ManufacturerURLGenerator()
        let url = try? urlGenerator.urlForFirstPage()
        XCTAssertNotNil(url)
        sut.callAPI(with: url!, completion: completion)
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
    }

    func testCallAPI_ThrowsErrorWhenJSONIsInvalid() {
        var theError: Error?
        let completion = { (carElementsDict: [String : AnyObject]?, error: Error?) in
            theError = error
        }
        let urlGenerator = ManufacturerURLGenerator()
        let url = try? urlGenerator.urlForFirstPage()
        XCTAssertNotNil(url)
        sut.callAPI(with: url!, completion: completion)
        let responseData = Data()
        mockURLSession.completionHendler?(responseData, nil, nil)
        XCTAssertNotNil(theError)
    }

    func  testCallAPI_ThrowsErrorWhenDataIsNill() {
        var theError: Error?
        let completion = { (carElementsDict: [String : AnyObject]?, error: Error?) in
            theError = error
        }
        let urlGenerator = ManufacturerURLGenerator()
        let url = try? urlGenerator.urlForFirstPage()
        XCTAssertNotNil(url)
        sut.callAPI(with: url!, completion: completion)
        mockURLSession.completionHendler?(nil, nil, nil)
        XCTAssertNotNil(theError)
    }

    func testCallAPI_ThrowsErrorWhenResponseHesError() {
        var theError: Error?
        let completion = { (carElementsDict: [String : AnyObject]?, error: Error?) in
            theError = error
        }
        let urlGenerator = ManufacturerURLGenerator()
        let url = try? urlGenerator.urlForFirstPage()
        XCTAssertNotNil(url)
        sut.callAPI(with: url!, completion: completion)
        let responseDict = ["": ""]
        let responseData = try! JSONSerialization.data(withJSONObject: responseDict, options: [])
        let error = NSError(domain: "Some", code: 1234, userInfo: nil)
        mockURLSession.completionHendler?(responseData, nil, error)
        XCTAssertNotNil(theError)
    }
    
}


extension APIClientTests {

    class MockURLSession: ICarURLSession {

        typealias Handler = (Data?, URLResponse?, Error?)
            -> Void
        var completionHendler: Handler?
        var url: URL?
        var dataTask = MockURLSessionDataTask()

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            self.completionHendler = completionHandler
            return dataTask

        }

    }

    class MockURLSessionDataTask: URLSessionDataTask {
        var resumeGotCalled = false

        override func resume() {
            resumeGotCalled = true
        }
    }
    
}
