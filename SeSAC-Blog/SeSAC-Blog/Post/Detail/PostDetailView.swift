//
//  PostDetailView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class PostDetailView: UIView, ViewRepresentable {
    let postView = PostView(nickname: "당근당근", dateTitle: "12/04", bodyTitle: "ㄷㅎㄷㅎㄷㄱㅎㄱㄷㅎㄷㅎㄱㄷㅎㄷㄱㅎㄷㅎㄷㄱㅎㄷㄱㅎ")
    let tableView = UITableView()
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
        textField.placeholder = "댓글을 입력해주세요"
        
        return textField
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
        addSubview(commentTextField)
        addSubview(postView)
        addSubview(tableView)
        
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
    }
    
    func setupConstraints() {
        postView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(postView.snp.bottom)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }

}
