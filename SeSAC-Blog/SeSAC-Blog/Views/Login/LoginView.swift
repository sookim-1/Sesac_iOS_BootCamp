//
//  LoginView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit
import SnapKit

class LoginView: UIView, ViewRepresentable {

    let emailTextField = BlogBasicTextField(placeholderText: "이메일 주소")
    let passwordTextField = BlogBasicTextField(placeholderText: "비밀번호")
    let loginButton = BlogBasicButton(backgroundColor: .systemGray4, title: "로그인")
    let passwordChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경하기", for: .normal)
        button.setTitleColor(.systemGray4, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return button
    }()
    
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
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(passwordChangeButton)
    }
    
    func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        passwordChangeButton.snp.makeConstraints { make in
            make.width.equalTo(loginButton.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
}
