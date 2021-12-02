//
//  UIColor+Ext.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

extension UIColor {
    class var customPink: UIColor? { return UIColor(named: "customPink") }
    
    class func color(data:Data) -> UIColor? {
         return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }

    func encode() -> Data? {
         return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
