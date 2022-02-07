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
    @Persisted var dday: Date?
    
    convenience init(name: String = "default", dday: Date?) {
        self.init()
        self.name = name
        self.dday = dday
    }
}
