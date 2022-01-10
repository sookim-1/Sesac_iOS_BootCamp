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

        configureTextView()
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
