//
//  SettingVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/22.
//

import UIKit
import SafariServices

class SettingVC: UIViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    func configureNavigationBar() {
        
        self.title = "설정"
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    @IBAction func clickedOpenSourceBtn(_ sender: UIButton) {
        openWebsite(urlString: "https://www.notion.so/3b5ae2ca85b342feba1489809c005344")
    }
    
    @IBAction func clickedServiceBtn(_ sender: UIButton) {
        openWebsite(urlString: "https://www.notion.so/3b5ae2ca85b342feba1489809c005344")
    }
    

    
    func openWebsite(urlString: String) {
        
        guard let blogUrl = URL(string: urlString) else {
            presentErrorAlertOnMainThread(title: "웹사이트 열 수 없음", message: FarewellError.notOpenURL.rawValue, buttonTitle: "확인")
            return
        }
        
        if ["http", "https"].contains(blogUrl.scheme?.lowercased() ?? "") {
            let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl)
            self.present(blogSafariView, animated: true, completion: nil)
        }
        else {
            presentErrorAlertOnMainThread(title: "웹사이트 열 수 없음", message: FarewellError.notOpenURL.rawValue, buttonTitle: "확인")
            UIApplication.shared.open(blogUrl, options: [:], completionHandler: nil)
        }
        
    }

}
