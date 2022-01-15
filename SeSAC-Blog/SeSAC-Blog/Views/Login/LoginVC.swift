//
//  LoginVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

final class LoginVC: BaseVC {

    private let mainView = LoginView()
    private let viewModel = LoginViewModel()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.emailTextField.becomeFirstResponder()
        hideKeyboard()
        bindingAllTextField()
        didChangeSetTarget()
        didExitSetTarget()
        didReturnSetTarget()

        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "새싹농장 로그인하기"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = ""
    }

    @objc func loginButtonClicked() {

        viewModel.checkValidate { isCheck in
            if isCheck {
                self.viewModel.login { result in
                    switch result {
                    case .success(let userData):
                        UserDefaults.standard.set(userData.jwt, forKey: "token")
                        print(userData.jwt)
                        self.showToast(message: "로그인 완료") {
                            DispatchQueue.main.async {
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: PostListVC())
                                windowScene.windows.first?.makeKeyAndVisible()
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.presentErrorAlertOnMainThread(title: "네트워크 에러", message: "로그인을 실패하였습니다.", buttonTitle: "확인")
                    }
                }
            } else {
                self.presentErrorAlertOnMainThread(title: "이메일 형식 에러", message: "이메일 형식을 맞춰주세요", buttonTitle: "확인")
            }
        }
    }

}

// MARK: - TextField 변화 감지하는 메서드
extension LoginVC {
    // MARK: - TextField 값 바인딩
    private func bindingAllTextField() {
        bindingTextField(viewModel.email, mainView.emailTextField)
        bindingTextField(viewModel.password, mainView.passwordTextField)
    }

    // MARK: - 텍스트필드 입력
    private func didChangeSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }

    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }

    // MARK: - 텍스트필드 입력종료 (외부요인에 의한 종료)
    private func didExitSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidExit(_:)), for: .editingDidEnd)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidExit(_:)), for: .editingDidEnd)
    }

    @objc func emailTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func passwordTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    // MARK: - 텍스트필드 Return키 종료
    private func didReturnSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
    }

    @objc func emailTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func passwordTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    private func checkEditTextField() {
        viewModel.checkEditAllTextField { isCheck in
            if isCheck {
                self.mainView.loginButton.isEnabled = true
                self.mainView.loginButton.backgroundColor = .systemGreen
            }
        }
    }

}
