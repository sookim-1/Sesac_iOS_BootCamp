//
//  BaseInterceptor.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        var dictionary: [String:String] = [:]
        
        dictionary.updateValue(UnsplashAPI.CLIENT_ID, forKey: "client_id")
        
        do {
            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
        } catch {
            print(error)
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        let data = ["statusCode": statusCode]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NetworkError.UnsplashAPI.AUTH_FAIL), object: nil, userInfo: data)
        
        completion(.doNotRetry)
    }
}
