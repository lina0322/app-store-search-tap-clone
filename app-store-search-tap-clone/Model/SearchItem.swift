//
//  SearchItem.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import Foundation

struct SearchItem {
    let term: String
    var country: String = "kr"
    var media: String = "software"
    
    var parameters: [String : String] {[
        "term": term,
        "country": country,
        "media": media,
    ]}
}
