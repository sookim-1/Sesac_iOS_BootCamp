//
//  File.swift
//  
//
//  Created by sookim on 2021/11/17.
//

import Fluent

struct CreateAccount: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("accounts")
            .id()
            .field("email", .string, .required)
            .field("password", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("accounts").delete()
    }
}
