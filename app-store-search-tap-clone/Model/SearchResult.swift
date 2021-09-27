//
//  SearchResult.swift
//  app-store-search-tap-clone
//
//  Created by lina on 2021/08/26.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Results]
}

struct Results : Decodable {
    let trackName : String? // 어플 이름
    let genres : [String]? // 장르(짧은 소개글)
    let averageUserRating : Double? // 별점 점수
    let userRatingCountForCurrentVersion: Int? // 별점 준 사람 수
    let formattedPrice : String? // 가격
    let version : String? // 업데이트 필요한지 확인하기위해
}
