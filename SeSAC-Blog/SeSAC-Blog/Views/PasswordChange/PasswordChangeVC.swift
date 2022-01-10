//
//  PasswordChangeVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class PasswordChangeVC: BaseVC {

    let mainView = PasswordChangeView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "비밀번호 변경"
    }

}
