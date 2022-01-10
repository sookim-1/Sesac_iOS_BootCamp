//
//  HomeView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit
import SnapKit

final class HomeView: UIView, ViewRepresentable {
    let imageView = UIImageView(image: UIImage(named: "logo_ssac_clear"))
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "당신 근처의 새싹농장"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    let signButton = BlogBasicButton(backgroundColor: .systemGreen, title: "가입하기")
    let loginView: UIView = UIView()
    let checkAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 계정이 있나요?"
        label.textColor = .systemGray4
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(signButton)

        // MARK: - LoginView만들기
        loginView.addSubview(checkAccountLabel)
        loginView.addSubview(loginButton)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginView)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.0 / 1.0)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
        }

        bodyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
        }

        signButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(loginView.snp.top)
            make.height.equalTo(50)
        }

        loginView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(signButton.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
        }

        checkAccountLabel.snp.makeConstraints { make in
            make.height.equalTo(loginView.snp.height).multipliedBy(0.5)
            make.center.equalTo(loginView.snp.center)
            make.trailing.equalTo(loginButton.snp.leading)
        }

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(loginView.snp.height).multipliedBy(0.5)
            make.centerY.equalTo(loginView.snp.centerY)
        }

    }

}
