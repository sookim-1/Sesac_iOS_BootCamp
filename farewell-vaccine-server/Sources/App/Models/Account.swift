//
//  File.swift
//  
//
//  Created by sookim on 2021/11/17.
//

import Foundation
import Fluent
import Vapor

final class Account: Model, Content {
    
    static let schema = "accounts" // table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    init() {}
    
    init(id: UUID? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
    
}
