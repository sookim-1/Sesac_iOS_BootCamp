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

        getData()
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }

    func getData() {
        viewModel.getPostData { result in
            switch result {
            case .success(let postData):
                self.postData = postData
                self.mainView.tableView.reloadData()
            case .failure(let error):
                if error.errorTag == 1 {
                    self.presentLoginVC()
                }
                print(error.localizedDescription)
                self.presentErrorAlertOnMainThread(title: "네트워크 에러", message: "데이터를 가져오는데 실패하였습니다.", buttonTitle: "확인")
            }
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailVC = PostDetailVC()

        postDetailVC.postData = postData[indexPath.row]
        self.navigationController?.pushViewController(postDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "삭제") { (_, _, completionHandler ) in
            let defaultAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                self.viewModel.deletePostData(id: self.postData[indexPath.row].id) { result in
                    switch result {
                    case .success(_):
                        self.getData()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.presentErrorAlertOnMainThread(title: "게시글 삭제할수없습니다.", message: "작성자를 확인하세요", buttonTitle: "확인")
                    }
                }
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

            let alert = UIAlertController(title: "게시글을 삭제하시겠습니까?",
                  message: "정말로 삭제하시겠어요?",
                  preferredStyle: .alert)

            alert.addAction(defaultAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

}
