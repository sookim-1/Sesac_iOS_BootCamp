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
    }

}
