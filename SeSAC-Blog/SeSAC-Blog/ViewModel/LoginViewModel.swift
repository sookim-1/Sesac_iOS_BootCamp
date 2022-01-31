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

        URLSession.shared.dataTask(with: request) { data, response, error in
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
                completion(.failure(.customError(errorMessage: "response상태코드 에러:\(response.statusCode)")))
                return
            }

            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(ResponseLoginModel.self, from: data)
                completion(.success(userData))
            } catch {
                completion(.failure(.customError(errorMessage: "디코딩 에러")))
            }
        }
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
