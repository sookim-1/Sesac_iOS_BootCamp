//
//  ViewController.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        let localRealm = try! Realm()
        
        let halfProfiles = localRealm.objects(HalfProfile.self)
        if !halfProfiles.isEmpty {
            let halfProfileUpdate = halfProfiles[0]
            
            try! localRealm.write {
                nameLabel.text = halfProfileUpdate.name
                descriptionLabel.text = "❤️"
            }
        }

        if let updateImage = loadImageFromDocumentDirectory(imageName: "profileImage.png") {
            
            mainImageView.image = updateImage
            descriptionLabel.text = "❤️"
        } else {
            mainImageView.image = UIImage(systemName: "photo")
        }
    }
    
    func configureNavigationBar() {        
        self.title = "이별차단"
    }
    
    func configureImageView() {
        mainImageView.contentMode = UIView.ContentMode.scaleAspectFill
        mainImageView.layer.cornerRadius = 100
        mainImageView.clipsToBounds = true
        mainImageView.layer.borderWidth = 10
        mainImageView.layer.borderColor = UIColor.customPink?.cgColor
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
}

