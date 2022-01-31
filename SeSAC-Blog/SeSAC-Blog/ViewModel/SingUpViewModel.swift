//
//  SingUpViewModel.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import Foundation

final class SignUpViewModel {
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var passwordConfirm: Observable<String> = Observable("")

    func signUp(completion:  @escaping (Result<Void, NetworkError>) -> Void) {
        let model = SignUpModel(username: username.value, email: email.value, password: password.value)
        var request = URLRequest(url: SeSacAPI.signUp.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)

        URLSession.requestNotDecode(endpoint: request, completion: completion)
    }

    func checkEditAllTextField(onComplete: @escaping (Bool) -> Void) {
        if username.value != "" && email.value != "" && password.value != "" && passwordConfirm.value != "" {
            onComplete(true)
        } else {
            onComplete(false)
        }
    }

    func checkValidate(onComplete: @escaping (ValidateSignUp) -> Void) {
        if !isValidEmail(text: email.value) {
            onComplete(.isValidEmail)
        } else if !(password.value == passwordConfirm.value) {
            onComplete(.isValidePassword)
        } else {
            onComplete(.success)
        }
    }

    private func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: text)
    }
}
