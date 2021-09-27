//
//  NetworkError.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/28.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failureResponse(code: Int?)
    case emptyData
}
