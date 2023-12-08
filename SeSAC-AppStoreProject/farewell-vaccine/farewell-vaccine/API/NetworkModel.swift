//
//  NetworkModel.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import Foundation

struct NetworkResults: Codable {
    var total: Int
    var total_pages: Int
    var results: [NetworkResult]
}

struct NetworkResult: Codable {
    var id: String
    var urls: URLs
}

struct URLs: Codable {
    var small: String
}
