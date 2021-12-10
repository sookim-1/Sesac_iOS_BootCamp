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
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
        configureTextView()
        
        let localRealm = try! Realm()
        let introduces = localRealm.objects(Introduce.self)
        
        if !introduces.isEmpty {
            let introduceUpdate = introduces[0]
            try! localRealm.write {
                mainTextView.text = introduceUpdate.text
            }
        }

        mainTextView.backgroundColor = loadColorFromDocumentDirectory(name: "colors")
        mainTextView.font = loadFontFromDocumentDirectory(fontName: "fonts")
        mainTextView.textColor = loadColorFromDocumentDirectory(name: "textColors")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    func configureNavigationBar() {
        self.title = "소개하기"

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
