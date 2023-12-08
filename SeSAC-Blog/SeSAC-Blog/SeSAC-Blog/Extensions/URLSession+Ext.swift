//
//  URLSession+Ext.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()

        return task
    }

    func tokenCodeValidate(httpMethodType: String, statusCode: Int) -> Bool {
        if (httpMethodType == "PUT" || httpMethodType == "DELETE") && statusCode == 401 {
            return false
        } else {
            if let _ = UserDefaults.standard.string(forKey: "token") {
                UserDefaults.standard.removeObject(forKey: "token")

                return true
            }
        }

        return false
    }

    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.customError(errorMessage: "네트워크에러")))
                    return
                }

                guard let data = data else {
                    completion(.failure(.customError(errorMessage: "데이터통신에러")))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.customError(errorMessage: "response응답 에러")))
                    return
                }

                guard response.statusCode == 200 else {
                    if session.tokenCodeValidate(httpMethodType: endpoint.httpMethod!, statusCode: response.statusCode) {
                        completion(.failure(.tokenExpirationError))
                    } else {
                        completion(.failure(.customError(errorMessage: "response상태코드 에러:\(response.statusCode)")))
                    }
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(.success(userData))
                } catch {
                    completion(.failure(.customError(errorMessage: "디코딩 에러")))
                }
            }
        }
    }

    static func requestNotDecode(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        session.dataTask(endpoint) { _, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.customError(errorMessage: "네트워크에러")))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.customError(errorMessage: "response응답 에러")))

                    return
                }

                guard response.statusCode == 200 else {
                    completion(.failure(.customError(errorMessage: "response상태코드 에러:\(response.statusCode)")))

                    return
                }

                completion(.success())
            }
        }
    }

}
