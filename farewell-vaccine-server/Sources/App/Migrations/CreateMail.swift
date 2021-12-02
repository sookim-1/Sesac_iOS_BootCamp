//
//  File.swift
//  
//
//  Created by sookim on 2021/11/17.
//

import Fluent

struct CreateMail: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("mails")
            .id()
            .field("from", .string, .required)
            .field("to", .string, .required)
            .field("content", .string)
            .field("font_name", .string)
            .field("background", .string)
            .field("font_size", .int)
            .field("font_color", .string)
            .field("weather", .string)
            .field("create_date", .date)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("mails").delete()
    }
}
