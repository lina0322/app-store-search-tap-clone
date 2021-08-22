//
//  NetworkProvider.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/22.
//

import Foundation

class ServiceProvider {

    static let shared = ServiceProvider()

    private var baseURL: String {
        return "https://itunes.apple.com/search"
    }

    func  getDataTest(parameters: [String: String], completion: @escaping ([String: Any]?) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL)  else { return }
        urlComponents.queryItems = parameters.map {(key, value) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)

        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) {(datas, response, error) in
            if error != nil {
                print("Network Error")
            }
            guard let data = datas else {return}
            do {
//                let responseObject = try JSONDecoder().decode(TestModel.self, from: data)
                let responseObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]

                completion(responseObject)
            } catch {
                print("JSON Parising Error")
            }
        }
        dataTask.resume()
    }
}
