//
//  PasswordChangeVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class PasswordChangeVC: BaseVC {

    let mainView = PasswordChangeView()
    let viewModel = PasswordChangeViewModel()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "비밀번호 변경"
        hideKeyboard()
        bindingTextField(viewModel.currentPassword, self.mainView.currentPasswordTextField)
        bindingTextField(viewModel.newPassword, self.mainView.newPasswordTextField)
        bindingTextField(viewModel.confirmNewPassword, self.mainView.confirmNewPasswordTextField)
        setTarget()
    }

    func setTarget() {
        mainView.currentPasswordTextField.addTarget(self, action: #selector(currentPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.newPasswordTextField.addTarget(self, action: #selector(newPasswordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.confirmNewPasswordTextField.addTarget(self, action: #selector(confirmNewPasswordTextFieldDidChange(_:)), for: .editingChanged)

        mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
    }

    @objc func currentPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.currentPassword.value = textfield.text ?? ""
    }

    @objc func newPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.newPassword.value = textfield.text ?? ""
    }

    @objc func confirmNewPasswordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.confirmNewPassword.value = textfield.text ?? ""
        mainView.changeButton.backgroundColor = .systemGreen
        mainView.changeButton.isEnabled = true
    }

    @objc func changeButtonClicked() {
        if mainView.newPasswordTextField.text == mainView.confirmNewPasswordTextField.text {
            viewModel.passwordChange(model: PasswordChangeModel(currentPassword: viewModel.currentPassword.value, newPassword: viewModel.newPassword.value, confirmNewPassword: viewModel.confirmNewPassword.value)) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    if error.errorTag == 1 {
                        self.presentLoginVC()
                    }
                    print(error.localizedDescription)
                    self.presentErrorAlertOnMainThread(title: "네트워크 에러", message: "비밀번호변경을 실패하였습니다.", buttonTitle: "확인")
                }
            }
        } else {
            presentErrorAlertOnMainThread(title: "비밀번호 에러", message: "비밀번호를 동일하게 입력하세요", buttonTitle: "확인")
        }

    }
}
