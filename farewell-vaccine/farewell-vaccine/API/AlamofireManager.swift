//
//  AlamofireManager.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import Foundation
import Alamofire

final class AlamofireManager {
    
    static let shared = AlamofireManager()
    
    let interceptors = Interceptor(interceptors:[
                            BaseInterceptor()
                        ])
    
    var session: Session
    
    private init() {
        session = Session(interceptor: interceptors)
    }
}
