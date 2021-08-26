//
//  MockURLSession.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import UIKit


protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class MockURLSessionDataTask: URLSessionDataTask {
    override init() { }
    var resumeDidCall: () -> Void = {}
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: URLSessionProtocol {
    var isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: URL(string: Config.baseURL)!,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        let failureResponse = HTTPURLResponse(url: URL(string: Config.baseURL)!,
                                              statusCode: 410,
                                              httpVersion: "2",
                                              headerFields: nil)
        let sessionDataTask = MockURLSessionDataTask()
        let sampleSearchResult = NSDataAsset.init(name: "searchResult")?.data

        sessionDataTask.resumeDidCall = {
            if self.isSuccess {
                completionHandler(sampleSearchResult, successResponse, nil)
            } else {
                completionHandler(nil, failureResponse, nil)
            }
        }
        return sessionDataTask
    }
}
