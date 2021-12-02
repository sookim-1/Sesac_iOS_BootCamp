//
//  HalfProfile.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import Foundation
import RealmSwift

class HalfProfile: Object {
    @Persisted var name: String?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
