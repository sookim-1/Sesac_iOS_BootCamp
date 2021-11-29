//
//  SettingVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/22.
//

import UIKit
import SafariServices

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    func configureNavigationBar() {
        self.title = "설정"
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    @IBAction func clickedOpenSourceBtn(_ sender: UIButton) {
        let blogUrl = NSURL(string: "https://www.notion.so/3b5ae2ca85b342feba1489809c005344")
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func clickedServiceBtn(_ sender: UIButton) {
        let blogUrl = NSURL(string: "https://www.notion.so/3b5ae2ca85b342feba1489809c005344")
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }

}
