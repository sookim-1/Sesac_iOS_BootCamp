//
//  LoginVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class LoginVC: BaseVC {

    let mainView = LoginView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "새싹농장 로그인하기"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = ""
    }

    func configure() {
        mainView.passwordChangeButton.addTarget(self, action: #selector(passwordChangeButtonClicked), for: .touchUpInside)
    }

    @objc func passwordChangeButtonClicked() {
        self.navigationController?.pushViewController(PasswordChangeVC(), animated: true)
    }
}
