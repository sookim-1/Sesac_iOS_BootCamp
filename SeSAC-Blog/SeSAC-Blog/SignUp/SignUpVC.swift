//
//  SignUpVC.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/04.
//

import UIKit

class SignUpVC: UIViewController {
    let mainView = SignUpView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "새싹농장 가입하기"
        
        LoginNetworkService.shared.postSign { result in
            switch result {
            case .success(let code):
                print(code)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
