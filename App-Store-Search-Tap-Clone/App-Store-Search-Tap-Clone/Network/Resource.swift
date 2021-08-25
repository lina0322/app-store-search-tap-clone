//
//  Resource.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/24.
//

import Foundation

struct Resource<T> {
    var urlRequest: URLRequest
    let parse: (Data) -> T?
}

extension Resource where T: Codable {
    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }

    init(url: String, parameters _parameters: [String: String]) {
        var component = URLComponents(string: url)
        var parameters = [URLQueryItem]()
        for (key, value) in _parameters {
            if key.isEmpty { continue }
            parameters.append(URLQueryItem(name: key, value: value))
        }

        if !parameters.isEmpty {
            component?.queryItems = parameters
        }

        if let url = component?.url {
            self.urlRequest = URLRequest(url: url)
        } else {
            self.urlRequest = URLRequest(url: URL(string: url)!)
        }
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }

    init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
        self.urlRequest = URLRequest(url: url)
        self.urlRequest.httpMethod = method.method

        switch method {
        case .post(let body), .delete(let body), .patch(let body), .put(let body):
            self.urlRequest.httpBody = try? JSONEncoder().encode(body)
            self.urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            self.urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        default: break
        }
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
}
