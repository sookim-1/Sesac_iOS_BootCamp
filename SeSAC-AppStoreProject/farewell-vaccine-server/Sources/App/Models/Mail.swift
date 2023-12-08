//
//  File.swift
//  
//
//  Created by sookim on 2021/11/17.
//

import Foundation
import Fluent
import Vapor

final class Mail: Model, Content {
    
    static let schema = "mails" // table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "from")
    var from: String
    
    @Field(key: "to")
    var to: String
    
    @Field(key: "content")
    var content: String
    
    @Field(key: "font_name")
    var font_name: String
    
    @Field(key: "background")
    var background: String
    
    @Field(key: "font_size")
    var font_size: Int
    
    @Field(key: "font_color")
    var font_color: String
    
    @Field(key: "weather")
    var weather: String
    
    @Field(key: "create_date")
    var create_date: Date
    
    init() {}
    
    init(id: UUID? = nil, from: String, to: String, content: String, font_name: String, background: String,
         font_size: Int, font_color: String, weather: String, create_date: Date) {
        self.id = id
        self.from = from
        self.to = to
        self.content = content
        self.font_name = font_name
        self.background = background
        self.font_size = font_size
        self.font_color = font_color
        self.weather = weather
        self.create_date = create_date
    }
    
}
