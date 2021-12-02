//
//  IntroduceTextView.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/12/02.
//

import Foundation
import RealmSwift

class Introduce: Object {
    @Persisted var text: String?
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
