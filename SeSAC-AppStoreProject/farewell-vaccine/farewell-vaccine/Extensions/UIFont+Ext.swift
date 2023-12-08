//
//  UIFont.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/12/02.
//

import UIKit

extension UIFont {
    class func font(data:Data) -> UIFont? {
         return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIFont
    }

    func encode() -> Data? {
         return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
