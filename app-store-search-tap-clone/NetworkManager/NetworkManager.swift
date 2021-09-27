//
//  NetworkManager.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import Foundation

struct NetworkManger {
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
            if let data = data {
                completion(.success(data))
                return
            }
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
        guard let url = component.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
