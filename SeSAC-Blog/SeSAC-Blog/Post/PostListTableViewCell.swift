//
//  TestTableViewCell.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class PostListTableViewCell: UITableViewCell, ViewRepresentable {
    static let identifier: String = "PostListTableViewCell"
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray2
        label.backgroundColor = .systemGray6
        
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .systemGray2

        return label
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
    
        // iOS15.0 버튼은 titlePadding 옵션으로 설정
        button.titleEdgeInsets.left = 10
        button.contentHorizontalAlignment = .leading
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        button.tintColor = .systemGray2
        button.setTitle("댓글쓰기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        view.alignment = .leading
        view.distribution = .fillEqually
        view.distribution = .equalSpacing
    
        return view
    }()
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        contentView.addSubview(commentButton)
        contentView.addSubview(stackView)
        
        [nickNameLabel, bodyLabel, dateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.7)
        }
        
        commentButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
    }
    
}
