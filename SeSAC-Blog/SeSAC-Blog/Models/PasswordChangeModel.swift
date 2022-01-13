//
//  PasswordChangeModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import Foundation

struct PasswordChangeModel: Codable {
    let currentPassword: String
    let newPassword: String
    let confirmNewPassword: String
}

struct ResponseChangeModel: Codable {
    let id: Int
}
