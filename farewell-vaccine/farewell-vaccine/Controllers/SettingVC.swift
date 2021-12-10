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
        openWebsite(urlString: "https://carnelian-tuba-ea2.notion.site/5abb78bad86a4d27b8401f89abc8378e")
    }
    
    @IBAction func clickedServiceBtn(_ sender: UIButton) {
        openWebsite(urlString: "https://carnelian-tuba-ea2.notion.site/5abb78bad86a4d27b8401f89abc8378e")
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
