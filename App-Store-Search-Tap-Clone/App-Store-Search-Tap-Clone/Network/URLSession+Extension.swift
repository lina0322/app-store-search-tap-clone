//
//  URLSession+Extension.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/24.
//

import Foundation



extension URLSession {
    func load<T>(_ resorce: Resource<T>, completion: @escaping (T?, Bool) -> Void) {
        dataTask(with: resorce.urlRequest) { data, response, _ in
            if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
                completion(data.flatMap(resorce.parse), true)
            } else {
                completion(nil, false)
            }
        }.resume()
    }
}
