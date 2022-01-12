//
//  String+Ext.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
