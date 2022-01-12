//
//  SignUpVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class SignUpVC: BaseVC {
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    var isCorrectPassword = true

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새싹농장 가입하기"
        mainView.emailTextField.becomeFirstResponder()
        hideKeyboard()

        bindingTextField(viewModel.username, mainView.usernameTextField)
        bindingTextField(viewModel.email, mainView.emailTextField)
        bindingTextField(viewModel.password, mainView.passwordTextField)
        setTarget()
    }

    func setTarget() {
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmTextFieldDidChange(_:)), for: .editingChanged)

        mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }

    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }

    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }

    @objc func confirmTextFieldDidChange(_ textfield: UITextField) {
        mainView.signButton.backgroundColor = .systemGreen
        mainView.signButton.isEnabled = true
    }

    @objc func signInButtonClicked() {
        isCorrectPassword = mainView.passwordTextField.text == mainView.confirmPasswordTextField.text
        if isValidEmail(text: viewModel.email.value) && isCorrectPassword {
            viewModel.signUp(model: SignUpModel(username: viewModel.username.value, email: viewModel.email.value, password: viewModel.password.value)) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
        } else if !isValidEmail(text: viewModel.email.value) {
            print("error")
        } else if !isCorrectPassword {
            print("error")
        }

    }
}
