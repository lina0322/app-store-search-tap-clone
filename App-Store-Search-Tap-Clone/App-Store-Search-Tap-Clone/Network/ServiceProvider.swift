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

    func  getDataTest(completion:@escaping (TestModel) -> Void) {
        let requestURL = baseURL
        guard let url = URL(string: requestURL) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) {(datas, response, error) in
            if error != nil {
                print("Network Error")
            }
            guard let data = datas else {return}
            do {
                let model = try JSONDecoder().decode(TestModel.self, from: data)
                completion(model)
            } catch {
                print("JSON Parising Error")
            }
        }
        dataTask.resume()
    }
}
