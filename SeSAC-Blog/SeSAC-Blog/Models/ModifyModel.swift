//
//  ModifyModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/13.
//

import Foundation

struct ModifyPostModel: Codable {
    let text: String
}

struct ModifyCommentModel: Codable {
    let comment: String
    let post: Int
}
