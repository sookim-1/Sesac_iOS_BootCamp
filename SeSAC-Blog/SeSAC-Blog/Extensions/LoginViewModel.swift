//
//  LoginViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

class LoginViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")

    func login(model: LoginModel, completion:  @escaping (Result<ResponseLoginModel, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        URLSession.request(endpoint: request, completion: completion)
    }
}
