//
//  Decoder.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import Foundation

struct Decoder {
    func decode<T: Decodable>(data: Data, to type: T.Type) -> T? {
        let decodedData = try? JSONDecoder().decode(type, from: data)
        return decodedData
    }
}
