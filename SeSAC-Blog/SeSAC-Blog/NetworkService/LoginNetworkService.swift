//
//  LoginNetworkService.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import Foundation

class LoginNetworkService {
    static let shared = LoginNetworkService()
    
    func postSign(completion: @escaping (Result<String, NetworkError>) -> Void) {
        let body = SignUpModel(username: "userna3me", email: "ema3il@naver.com", password: "1234")

        var request = URLRequest(url: SeSacAPI.signUp.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.customError(errorMessage: "error 발생")))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.customError(errorMessage: "상태코드 오류")))
                return
            }

            guard let _ = data else {
                completion(.failure(.customError(errorMessage: "데이터 오류")))
                return
            }
            completion(.success("회원가입 성공"))
        }.resume()
    }
    
}
