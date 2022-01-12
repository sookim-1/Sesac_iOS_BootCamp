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

        bindingTextField(viewModel.commentText, self.mainView.commentTextField)
        mainView.commentTextField.addTarget(self, action: #selector(commentTextFieldDidChange(_:)), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func configure() {
        guard let postData = postData else { return }

        self.mainView.postView.nicknameLabel.text = postData.user.username
        self.mainView.postView.bodyLabel.text = postData.text
        self.mainView.postView.dateLabel.text = self.dateFormatter.string(from: postData.updatedAt.toDate()!)
        self.mainView.commentTextField.delegate = self

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

    @objc func commentTextFieldDidChange(_ textfield: UITextField) {
        viewModel.commentText.value = textfield.text ?? ""
    }

    @objc func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
    }

    @objc func keyboardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += keyboardHeight
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

extension PostDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        print(viewModel.commentText.value, postData?.id ?? 0)
        viewModel.postComment(model: CommentModel(comment: viewModel.commentText.value, post: postData?.id ?? 0)) { result in
            switch result {
            case .success(_):
                print("success")

                self.view.endEditing(true)
            case .failure(let error):
                if error.errorTag == 1 {
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginVC())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
                print(error.localizedDescription)
                self.presentErrorAlertOnMainThread(title: "댓글 작성 오류", message: "댓글을 작성할 수 없습니다.", buttonTitle: "확인")
                self.view.endEditing(true)
            }
        }
        return true
    }

}
