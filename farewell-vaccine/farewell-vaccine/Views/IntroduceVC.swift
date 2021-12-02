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
        let localRealm = try! Realm()

        try! localRealm.write {
            let introduce = localRealm.objects(Introduce.self)
            mainTextView.text = introduce.last?.text
        }

        mainTextView.backgroundColor = loadColorFromDocumentDirectory(name: "colors")
        mainTextView.font = loadFontFromDocumentDirectory(fontName: "fonts")
        mainTextView.textColor = loadColorFromDocumentDirectory(name: "textColors")
        
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
    }
    
    func loadColorFromDocumentDirectory(name: String) -> UIColor? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let colorURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(name)
            if let data = try? Data(contentsOf: colorURL) {
                return UIColor.color(data: data)
            }
        }
        return nil
    }
    
    func loadFontFromDocumentDirectory(fontName: String) -> UIFont? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let fontURL = URL(fileURLWithPath: directoryPath).appendingPathComponent("fonts")
            if let data = try? Data(contentsOf: fontURL) {
                return UIFont.font(data: data)
            }
 
        }
        return nil
    }
}
