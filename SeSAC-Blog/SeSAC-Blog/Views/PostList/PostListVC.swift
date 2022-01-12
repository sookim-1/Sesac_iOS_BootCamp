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
    let viewModel = PostListViewModel()
    var postData: [ResponsePost] = []
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter
    }

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.actionButton.addTarget(self, action: #selector(presentPostEditVC), for: .touchUpInside)
        viewModel.getPostData { result in
            switch result {
            case .success(let postData):
                self.postData = postData
                self.mainView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                self.presentErrorAlertOnMainThread(title: "네트워크 에러", message: "데이터를 가져오는데 실패하였습니다.", buttonTitle: "확인")
            }
        }
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }

    @objc func presentPostEditVC() {
        self.navigationController?.pushViewController(PostEditVC(), animated: true)
    }

}

extension PostListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.identifier, for: indexPath) as? PostListTableViewCell else {
            return UITableViewCell()
        }

        cell.nickNameLabel.text = postData[indexPath.row].user.username
        cell.bodyLabel.text = postData[indexPath.row].text
        cell.dateLabel.text = dateFormatter.string(from: postData[indexPath.row].updatedAt.toDate()!)

        cell.commentButton.setTitle("댓글 \(postData[indexPath.row].comments.count)", for: .normal)

        return cell
    }

}
