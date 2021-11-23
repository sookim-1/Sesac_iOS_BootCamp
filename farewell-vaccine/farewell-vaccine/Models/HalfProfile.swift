//
//  HalfProfile.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import Foundation
import RealmSwift

class HalfProfile: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
}
