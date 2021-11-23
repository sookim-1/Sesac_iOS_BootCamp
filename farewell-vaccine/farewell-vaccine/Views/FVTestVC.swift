//
//  FVTestVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/21.
//

import UIKit

class FVTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.title = "테스트하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customPink]
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }

}
