//
//  ServiceProvider.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/22.
//

import Foundation

class ServiceProvider {

    static let shared = ServiceProvider()

    private lazy var defaultSession = URLSession(configuration: .default)

    private init() { }

    func  getDataTest(parameters: [String: String], completion: @escaping (Result<[TestModel]?, APIError>) -> Void) {
        let url = Config.baseURL
        let resource = Resource<[TestModel]>(url: url, parameters: parameters)
        defaultSession.load(resource) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
