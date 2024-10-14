//
//  TVShowsResponse.swift
//  BM Task 1
//
//  Created by Mahmoud ELsharkawy on 25/07/2024.
//

import Foundation

struct TVShowsResponse: Codable {
    let show: TVShow
    
}

struct TVShow: Codable {
    let id: Int?
    let name: String?
    let image: TVShowImage?
    let rating: TVShowRating?
    let officialSite: String?
}

struct TVShowImage: Codable {
    let medium: String?
    let original: String?
}
struct TVShowRating: Codable {
    let average: Double?
}
