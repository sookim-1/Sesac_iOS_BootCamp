//
//  LoginVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class LoginVC: UIViewController {
    
    let mainView = LoginView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "새싹농장 로그인하기"
    }
    
}
