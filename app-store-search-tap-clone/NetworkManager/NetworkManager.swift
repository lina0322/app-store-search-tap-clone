//
//  NetworkManager.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import Foundation

struct NetworkManger {
    private enum NetworkError: Error {
        case invalidURL
        case failureResponse(code: Int?)
        case emptyData
    }
    
    enum HTTPMethod: String {
        case get
    }
    
    var urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request(urlString: String, param: [String : String]? = nil, method: HTTPMethod = .get, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let urlRequest = makeURLRequest(urlString: urlString, param: param, method: method) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(.failure(NetworkError.failureResponse(code: statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    private func makeURLRequest(urlString: String, param: [String : String]? = nil, method: HTTPMethod = .get) -> URLRequest? {
        guard var component = URLComponents(string: urlString) else {
            return nil
        }
        if let param = param {
            var queryItems: [URLQueryItem] = []
            for (key, value) in param {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            component.queryItems = queryItems
        }
        
        var urlRequest = URLRequest(url: component.url!)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
