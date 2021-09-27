//
//  app_store_search_tap_cloneTests.swift
//  app-store-search-tap-cloneTests
//
//  Created by lina on 2021/08/26.
//

import XCTest
@testable import app_store_search_tap_clone

class app_store_search_tap_cloneTests: XCTestCase {
    let searchItem = SearchItem(term: "카카오톡")

    func test_networkManager_success() {
        let mockNetworkManager = NetworkManger(urlSession: MockURLSession())
        mockNetworkManager.request(urlString: Config.baseURL, param: searchItem.parameters) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let data):
                let result = Decoder().decode(data: data, to: SearchResult.self)?.results[0]
                XCTAssertEqual(result?.trackName, "카카오톡 KakaoTalk")
                XCTAssertEqual(result?.genres?[0], "소셜 네트워킹")
                XCTAssertEqual(result?.formattedPrice, "무료")
                XCTAssertEqual(result?.version, "9.4.7")

            }
        }
    }
    
    func test_networkManager_failure() {
        let mockNetworkManager = NetworkManger(urlSession: MockURLSession(isSuccess: false))
        mockNetworkManager.request(urlString: Config.baseURL, param: searchItem.parameters) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let data):
                let result = Decoder().decode(data: data, to: SearchResult.self)
                XCTAssertNil(result)
            }
        }
    }
}
