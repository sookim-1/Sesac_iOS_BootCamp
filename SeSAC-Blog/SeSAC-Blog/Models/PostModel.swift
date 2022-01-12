//
//  PostModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

struct ResponsePost: Codable {
    let id: Int
    let text: String
    let user: PostUser
    let createdAt, updatedAt: String
    let comments: [ResponseComment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

struct PostUser: Codable {
    let username: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case username
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
