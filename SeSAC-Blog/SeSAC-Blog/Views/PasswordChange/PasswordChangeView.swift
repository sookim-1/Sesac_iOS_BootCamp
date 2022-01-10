//
//  PasswordChangeView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit
import SnapKit

class PasswordChangeView: UIView, ViewRepresentable {

    let currentPasswordTextField = BlogBasicTextField(placeholderText: "현재 비밀번호")
    let newPasswordTextField = BlogBasicTextField(placeholderText: "변경할 비밀번호")
    let confirmNewPasswordTextField = BlogBasicTextField(placeholderText: "변경할 비밀번호 확인")
    let changeButton = BlogBasicButton(backgroundColor: .systemGray4, title: "변경하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(currentPasswordTextField)
        addSubview(newPasswordTextField)
        addSubview(confirmNewPasswordTextField)
        addSubview(changeButton)
    }
    
    func setupConstraints() {
        currentPasswordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(20)
        }
        
        confirmNewPasswordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(20)
        }
        
        changeButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(confirmNewPasswordTextField.snp.bottom).offset(20)
        }
    }
}
