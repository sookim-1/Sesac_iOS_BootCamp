//
//  PostListView.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit
import JJFloatingActionButton

class PostListView: UIView, ViewRepresentable {
    let titleView = UIView()
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "최근 게시물을 확인하세요"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    let tableView = UITableView()
    let actionButton = JJFloatingActionButton()
    let indicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubview(tableView)
        addSubview(titleView)
        titleView.backgroundColor = .systemGray6
        titleView.addSubview(titleLable)
        tableView.register(PostListTableViewCell.self, forCellReuseIdentifier: PostListTableViewCell.identifier)

        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = true
        bringSubviewToFront(indicatorView)
    }

    func setupConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(100)
        }

        titleLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }

        actionButton.display(inView: self)
    }

    func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView
    }

}
