//
//  ViewController.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/03.
//

import UIKit

class HomeVC: UIViewController {
    let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configure()
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
