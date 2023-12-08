//
//  SignUpVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

final class SignUpVC: BaseVC {

    private let mainView = SignUpView()
    private let viewModel = SignUpViewModel()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새싹농장 가입하기"
        mainView.emailTextField.becomeFirstResponder()
        hideKeyboard()
        bindingAllTextField()
        didChangeSetTarget()
        didExitSetTarget()
        didReturnSetTarget()

        mainView.signButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    @objc func signInButtonClicked() {
        viewModel.checkValidate { validate in
            switch validate {
            case .success:
                self.viewModel.signUp { result in
                    switch result {
                    case .success():
                        self.showToast(message: "회원가입완료") {
                            DispatchQueue.main.async {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    case .failure(let error):
                        print("\(error)")
                    }
                }
            case .isValidEmail:
                self.presentErrorAlertOnMainThread(title: "이메일 형식 에러", message: "이메일 형식을 맞춰주세요", buttonTitle: "확인")
            case .isValidePassword:
                self.presentErrorAlertOnMainThread(title: "비밀번호 에러", message: "비밀번호를 동일하게 입력하세요", buttonTitle: "확인")
            }
        }
    }

}

// MARK: - TextField 변화 감지하는 메서드
extension SignUpVC {

    // MARK: - TextField 값 바인딩
    private func bindingAllTextField() {
        bindingTextField(viewModel.email, mainView.emailTextField)
        bindingTextField(viewModel.username, mainView.usernameTextField)
        bindingTextField(viewModel.password, mainView.passwordTextField)
        bindingTextField(viewModel.passwordConfirm, mainView.confirmPasswordTextField)
    }

    // MARK: - 텍스트필드 입력
    private func didChangeSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmTextFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }

    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }

    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }

    @objc func confirmTextFieldDidChange(_ textfield: UITextField) {
        viewModel.passwordConfirm.value = textfield.text ?? ""
    }

    // MARK: - 텍스트필드 입력종료 (외부요인에 의한 종료)
    private func didExitSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidExit(_:)), for: .editingDidEnd)
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidExit(_:)), for: .editingDidEnd)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidExit(_:)), for: .editingDidEnd)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmTextFieldDidExit(_:)), for: .editingDidEnd)
    }

    @objc func usernameTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func emailTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func passwordTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func confirmTextFieldDidExit(_ textfield: UITextField) {
        checkEditTextField()
    }

    // MARK: - 텍스트필드 Return키 종료
    private func didReturnSetTarget() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
        mainView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
        mainView.confirmPasswordTextField.addTarget(self, action: #selector(confirmTextFieldDidReturn(_:)), for: .editingDidEndOnExit)
    }

    @objc func emailTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func usernameTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func passwordTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    @objc func confirmTextFieldDidReturn(_ textfield: UITextField) {
        checkEditTextField()
    }

    private func checkEditTextField() {
        viewModel.checkEditAllTextField { isCheck in
            if isCheck {
                self.mainView.signButton.isEnabled = true
                self.mainView.signButton.backgroundColor = .systemGreen
            }
        }
    }
}
