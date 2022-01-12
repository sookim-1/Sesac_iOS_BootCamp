//
//  CommentModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

struct ResponseComment: Codable {
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
