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
    case tokenExpirationError

    var errorTag: Int? {
        switch self {
        case .invalidError:
            return 0
        case .tokenExpirationError:
            return 1
        case .customError(errorMessage: _):
            return 2
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidError:
            return "알 수 없는 에러"
        case .tokenExpirationError:
            return "401에러"
        case .customError(errorMessage: let errorMessage):
            return "\(errorMessage)"
        }
    }
}
