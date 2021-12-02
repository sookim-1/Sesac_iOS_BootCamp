//
//  UnsplashRouter.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import Foundation
import Alamofire

enum UnsplashRouter: URLRequestConvertible {
    case searchPhotos(term: String)
    
    var baseURL: URL {
        return URL(string: UnsplashAPI.BASE_URL + "search/")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var endPoint: String {
        return "photos/"
    }
    
    var parameters: [String: String] {
        switch self {
        case let .searchPhotos(term):
            return ["query": term]
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
        return request
    }
}
