//
//  PostView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class PostView: UIView {

    let profileView = UIView()
    let nicknameLabel = UILabel()
    let dateLabel = UILabel()
    let bodyLabel = UILabel()
    let profileImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(nickname: String, dateTitle: String, bodyTitle: String) {
        super.init(frame: .zero)

        nicknameLabel.text = nickname
        dateLabel.text = dateTitle
        bodyLabel.text = bodyTitle

        configure()
        setConstraints()
    }

    private func configure() {
        addSubview(profileView)
        profileView.addSubview(nicknameLabel)
        profileView.addSubview(dateLabel)
        profileView.addSubview(profileImageView)

        profileImageView.image = UIImage(systemName: "person.crop.circle")

        addSubview(bodyLabel)
    }

    private func setConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }

        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(profileView.snp.height).multipliedBy(1)
            make.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }

        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.5)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.5)
        }

        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

}
