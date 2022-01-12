//
//  CommentModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

struct PostComment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct ResponseComment: Codable {
    let id: Int
    let comment: String
    let user: CommentUser
    let post: CommentPost
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct CommentUser: Codable {
    let id: Int
    let username: String
    let email: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct CommentPost: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
