//
//  PostDetailVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit

class PostDetailVC: BaseVC {
    let mainView = PostDetailView()
    let viewModel = PostDetailViewModel()
    var postData: ResponsePost?
    var commentData: [ResponseComment] = []
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

        hideKeyboard()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        configure()
    }

    func configure() {
        guard let postData = postData else { return }

        self.mainView.postView.nicknameLabel.text = postData.user.username
        self.mainView.postView.bodyLabel.text = postData.text
        self.mainView.postView.dateLabel.text = self.dateFormatter.string(from: postData.updatedAt.toDate()!)

        viewModel.getCommentData(id: postData.id) { result in
            switch result {
            case .success(let commentData):
                self.commentData = commentData
                self.mainView.tableView.reloadData()
            case .failure(let error):
                if error.errorTag == 1 {
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginVC())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
                print(error.localizedDescription)
                self.presentErrorAlertOnMainThread(title: "네트워크 에러", message: "데이터를 가져오는데 실패하였습니다.", buttonTitle: "확인")
            }
        }
    }

}

extension PostDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }

        cell.titleLabel.text = commentData[indexPath.row].user.username
        cell.bodyLabel.text = commentData[indexPath.row].comment

        return cell
    }

}
