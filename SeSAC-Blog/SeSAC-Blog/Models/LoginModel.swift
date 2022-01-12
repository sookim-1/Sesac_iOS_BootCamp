//
//  LoginModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import Foundation

struct LoginModel: Codable {
    let identifier: String
    let password: String
}

struct ResponseLoginModel: Codable {
    let jwt: String
    let user: LoginUser
}

struct LoginUser: Codable {
    let id: Int
    let username: String
    let email: String
}
