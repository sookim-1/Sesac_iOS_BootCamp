//
//  TestVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class PostListVC: BaseVC {

    let mainView = PostListView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.actionButton.addTarget(self, action: #selector(presentPostEditVC), for: .touchUpInside)
    }

    @objc func presentPostEditVC() {
        print("edit")
    }

}

extension PostListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.identifier, for: indexPath) as? PostListTableViewCell else {
            return UITableViewCell()
        }
        cell.nickNameLabel.text = "미묘한도사"
        cell.bodyLabel.text = "드라이브가실분 심심해영"
        cell.dateLabel.text = "12/04"

        cell.commentButton.setTitle("댓글 4", for: .normal)
        return cell
    }

}
