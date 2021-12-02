//
//  IntroduceVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit
import RealmSwift

class IntroduceVC: UIViewController {

    @IBOutlet weak var mainTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTextView()
    }
    
    func configureNavigationBar() {
        self.title = "소개하기"
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
    
    func configureTextView() {
        mainTextView.layer.borderWidth = 10
        mainTextView.layer.borderColor = UIColor.systemGray4.cgColor
        mainTextView.isEditable = false
        
        let localRealm = try! Realm()
        
        if localRealm.isEmpty {
            mainTextView.text = " "
        }
        else {
            let introduceText = localRealm.objects(IntroduceText.self)
            mainTextView.text = introduceText[0].text
        }
    }
    
}
