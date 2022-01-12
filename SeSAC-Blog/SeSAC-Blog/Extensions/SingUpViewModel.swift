//
//  SingUpViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

class SignUpViewModel {
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")

    func signUp(model: SignUpModel, completion:  @escaping (Result<ResponseSignUpModel, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.signUp.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        URLSession.request(endpoint: request, completion: completion)
    }
}
