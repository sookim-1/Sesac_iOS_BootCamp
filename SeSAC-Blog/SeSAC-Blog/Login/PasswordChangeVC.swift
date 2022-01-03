//
//  PasswordChangeVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class PasswordChangeVC: UIViewController {

    let mainView = PasswordChangeView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "비밀번호 변경"
    }

}
