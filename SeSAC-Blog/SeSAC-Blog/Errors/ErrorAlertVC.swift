//
//  ErrorAlertVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/12.
//

import UIKit
import SnapKit

class ErrorAlertVC: UIViewController {

    let containerView = UIView()
    let titleLabel = ErrorTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = ErrorBodyLabel(textAlignment: .center)
    let actionButton = ErrorButton(backgroundColor: .systemPink, title: "확인")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    let padding: CGFloat = 20

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(220)
        }
    }

    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "에러 발생"

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-padding)
            make.height.equalTo(28)
        }
    }

    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "확인", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-padding)
            make.height.equalTo(44)
        }
    }

    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "확인 할 수 없음"
        messageLabel.numberOfLines = 4

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-padding)
            make.bottom.equalTo(actionButton.snp.top).offset(-12)
        }
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
