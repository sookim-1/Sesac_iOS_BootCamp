//
//  IntroduceText.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/12/01.
//

import Foundation
import RealmSwift
import UIKit

//struct Route {
//    fileprivate (set) var uifonts: [UIFont]
//    fileprivate (set) var uicolors: [UIColor]
//    
//    init() {
//        uifonts = []
//        uicolors = []
//    }
//    
//    init(fonts: [UIFont], colors: [UIColor]) {
//        self.uifonts = fonts
//        self.uicolors = colors
//    }
//}
//
//class IntroduceText: Object {
//    @Persisted var text: String?
//    @Persisted var uifont: Data? = nil
//    @Persisted var uicolor: Data? = nil
//    
//    convenience init(route: Route) {
//        self.init()
//        self.uifont = NSKeyedArchiver.archivedData(withRootObject: route.uifonts)
//        self.uicolor = NSKeyedArchiver.archivedData(withRootObject: route.uicolors)
//    }
//
//    func route() -> Route {
//        if let uifont = uifont,
//            let uifonts = NSKeyedUnarchiver.unarchiveObject(with: uifont) as? [UIFont],
//            let uicolor = uicolor,
//            let uicolors = NSKeyedUnarchiver.unarchiveObject(with: uicolor) as? [UIColor] {
//            return Route(fonts: uifonts, colors: uicolors)
//        }
//        return Route()
//    }
//}
//
//struct RealmStore: DataStore {
//    let realm = try! Realm()
//
//    func store(route: Route) {
//        let routeRealm = IntroduceText(route: route)
//        try! realm.write {
//            realm.add(routeRealm)
//        }
//    }
//
//    func routes() -> [Route] {
//        let routesRealm = realm.objects(IntroduceText.self)
//        let routes = routesRealm.map() { $0.route() }
//        return Array(routes)
//    }
//}
//
//protocol DataStore {
//    func store(route: Route)
//    func routes() -> [Route]
//}
