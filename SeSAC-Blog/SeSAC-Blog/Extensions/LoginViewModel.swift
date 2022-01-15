//
//  LoginViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

final class LoginViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")

    func login(completion:  @escaping (Result<ResponseLoginModel, NetworkError>) -> Void) {
        let model = LoginModel(identifier: email.value, password: password.value)

        var request = URLRequest(url: SeSacAPI.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)
        URLSession.request(endpoint: request, completion: completion)
    }

    func checkEditAllTextField(onComplete: @escaping (Bool) -> Void) {
        if email.value != "" && password.value != "" {
            onComplete(true)
        } else {
            onComplete(false)
        }
    }

    func checkValidate(onComplete: @escaping (Bool) -> Void) {
        if !isValidEmail(text: email.value) {
            onComplete(false)
        } else {
            onComplete(true)
        }
    }

    private func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: text)
    }

}
