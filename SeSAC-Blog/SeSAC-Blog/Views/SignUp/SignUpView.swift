//
//  SignUpView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit
import SnapKit

class SignUpView: UIView, ViewRepresentable {

    let emailTextField = BlogBasicTextField(placeholderText: "이메일 주소")
    let nicknameTextField = BlogBasicTextField(placeholderText: "닉네임")
    let passwordTextField = BlogBasicTextField(placeholderText: "비밀번호")
    let confirmPasswordTextField = BlogBasicTextField(placeholderText: "비밀번호 확인")
    let signButton = BlogBasicButton(backgroundColor: .systemGray4, title: "가입하기")

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubview(emailTextField)
        addSubview(nicknameTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(signButton)
    }

    func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
        }

        confirmPasswordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }

        signButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(20)
        }
    }
}
