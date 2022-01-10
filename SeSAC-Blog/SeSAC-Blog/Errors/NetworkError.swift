//
//  NetworkError.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidError
    case customError(errorMessage: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidError:
            return "알 수 없는 에러"
        case .customError(errorMessage: let errorMessage):
            return "\(errorMessage)"
        }
    }
}
