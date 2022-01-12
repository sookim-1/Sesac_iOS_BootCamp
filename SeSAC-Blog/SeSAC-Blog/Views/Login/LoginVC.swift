//
//  LoginVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class LoginVC: BaseVC {

    let mainView = LoginView()
    let viewModel = LoginViewModel()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindingTextField(viewModel.email, self.mainView.emailTextField)
        bindingTextField(viewModel.password, self.mainView.passwordTextField)
        setTarget()
        hideKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "새싹농장 로그인하기"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = ""
    }

    func setTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        mainView.passwordChangeButton.addTarget(self, action: #selector(passwordChangeButtonClicked), for: .touchUpInside)
    }

    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }

    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        mainView.loginButton.backgroundColor = .systemGreen
        mainView.loginButton.isEnabled = true
    }

    @objc func loginButtonClicked() {
        if isValidEmail(text: viewModel.email.value) {
            viewModel.Login(model: LoginModel(identifier: viewModel.email.value, password: viewModel.password.value)) { result in
                switch result {
                case .success(let userData):
                    UserDefaults.standard.set(userData.jwt, forKey: "token")
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostListVC())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                case .failure(let error):
                    print(error.localizedDescription)

                }
            }
        } else {
            print("error")
        }
    }

    @objc func passwordChangeButtonClicked() {
        self.navigationController?.pushViewController(PasswordChangeVC(), animated: true)
    }
}
