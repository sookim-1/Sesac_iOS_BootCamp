//
//  PasswordChangeViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/13.
//

import Foundation

class PasswordChangeViewModel {
    var currentPassword: Observable<String> = Observable("")
    var newPassword: Observable<String> = Observable("")
    var confirmNewPassword: Observable<String> = Observable("")

    func passwordChange(model: PasswordChangeModel, completion:  @escaping (Result<ResponseChangeModel, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.changePassword.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
}
