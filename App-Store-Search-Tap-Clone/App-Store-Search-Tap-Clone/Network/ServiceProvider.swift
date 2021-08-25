//
//  NetworkProvider.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/22.
//

import Foundation

class ServiceProvider {

    enum APIError: LocalizedError {
        case urlNotSupport
        case noData

        var errorDesCription: String? {
            switch self {
            case .urlNotSupport: return "URL NOT Supported"
            case .noData: return "Has No Data"
            }
        }
    }

    static let shared = ServiceProvider()

    private var baseURL: String {
        return "https://itunes.apple.com/search"
    }

    private lazy var defaultSession = URLSession(configuration: .default)

    private init() { }

    func  getDataTest(parameters: [String: String], completion: @escaping (Result<[TestModel], APIError>) -> Void) {
        let url = Config.baseURL
        let resource = Resource<[TestModel]>(url: url, parameters: parameters)
        defaultSession.load(resource) { userDatas, res in
            guard let data = userDatas, !data.isEmpty else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }
    }
}
