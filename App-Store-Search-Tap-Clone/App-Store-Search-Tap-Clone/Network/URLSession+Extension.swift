//
//  URLSession+Extension.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/24.
//

import Foundation

extension URLSession {

    func load<T>(_ resorce: Resource<T>, completion: @escaping (Result<T?, APIError>) -> Void) {
        dataTask(with: resorce.urlRequest) { data, response, _ in
            if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
                completion(.success(data.flatMap(resorce.parse)))
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
