//
//  PostEditVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/11.
//

import UIKit
import SnapKit

class PostEditVC: BaseVC {
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새싹농장 글쓰기"
        hideKeyboard()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(editFinish))
        configureTextView()
    }

    @objc func editFinish() {
        editPostData(text: textView.text) { result in
            switch result {
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                if error.errorTag == 1 {
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: LoginVC())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
                print(error.localizedDescription)
                self.presentErrorAlertOnMainThread(title: "게시글 작성 오류", message: "게시글을 작성할 수 없습니다.", buttonTitle: "확인")
            }
        }
    }

    func editPostData(text: String, completion:  @escaping (Result<ResponsePost, NetworkError>) -> Void) {
        var request = URLRequest(url: SeSacAPI.editPost.url)
        request.httpMethod = "POST"
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(.tokenExpirationError))
            return
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.request(endpoint: request, completion: completion)
    }

    func configureTextView() {
        view.addSubview(textView)

        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
