//
//  ModifyVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class ModifyVC: BaseVC {

    let textView = UITextView()
    let viewModel = ModifyViewModel()
    var isCheckPost = true
    var postId = 0
    var commentId = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "수정"
        hideKeyboard()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(modifyFinish))
        configureTextView()
    }

    @objc func modifyFinish() {
        if isCheckPost {
            viewModel.modifyPostData(id: postId, model: ModifyPostModel(text: textView.text)) { result in
                switch result {
                case .success(_):
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    if error.errorTag == 1 {
                        self.presentLoginVC()
                    }
                    print(error.localizedDescription)
                    self.presentErrorAlertOnMainThread(title: "게시글 수정 오류", message: "게시글을 수정할 수 없습니다.", buttonTitle: "확인")
                }
            }
        } else {
            viewModel.modifyCommentData(id: commentId, model: ModifyCommentModel(comment: textView.text, post: postId)) { result in
                switch result {
                case .success(_):
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    if error.errorTag == 1 {
                        self.presentLoginVC()
                    }
                    print(error.localizedDescription)
                    self.presentErrorAlertOnMainThread(title: "댓글 수정 오류", message: "댓글을 수정할 수 없습니다.", buttonTitle: "확인")
                }
            }
        }
    }

    func modifyPost(postId: Int) {
        self.postId = postId
    }

    func modifyComment(postId: Int, commentId: Int) {
        self.commentId = commentId
        self.postId = postId
    }

    func configureTextView() {
        view.addSubview(textView)
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.systemGray4.cgColor

        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
