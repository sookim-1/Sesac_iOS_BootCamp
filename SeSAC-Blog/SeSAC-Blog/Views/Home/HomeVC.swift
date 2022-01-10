//
//  ViewController.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/03.
//

import UIKit

class HomeVC: BaseVC {
    let mainView = HomeView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        configure()
    }

    func setUpNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")

        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }

    func configure() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
    }

    @objc func loginButtonClicked() {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }

    @objc func signButtonClicked() {
        self.navigationController?.pushViewController(SignUpVC(), animated: true)
    }
}
