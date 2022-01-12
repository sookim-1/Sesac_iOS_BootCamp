//
//  SignUpModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import Foundation

struct SignUpModel: Codable {
    let username: String
    let email: String
    let password: String
}

struct ResponseSignUpModel: Codable {
    let jwt: String
    let user: SignUpUser
}

struct SignUpUser: Codable {
    let id: Int
    let username: String
    let email: String
}
