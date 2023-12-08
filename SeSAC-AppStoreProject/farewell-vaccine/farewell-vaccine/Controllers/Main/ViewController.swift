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
        
        self.title = "이별차단"

        if let updateImage = loadImageFromDocumentDirectory(imageName: "profileImage.png") {
            
            mainImageView.image = updateImage
            checkHalfProfileData()
        } else {
            mainImageView.image = UIImage(systemName: "photo")
            checkHalfProfileData()
        }
    }
    
    func distanceDate(dday: Date) {
        guard let distance = Calendar.current.dateComponents([.day], from: dday, to: Date()).day else {
            return
        }
        descriptionLabel.text = "❤️ \(distance)일째"
    }
    
    func checkHalfProfileData() {
        let localRealm = try! Realm()
        
        let halfProfiles = localRealm.objects(HalfProfile.self)
        if !halfProfiles.isEmpty {
            let halfProfileUpdate = halfProfiles[0]
            
            try! localRealm.write {
                nameLabel.text = halfProfileUpdate.name
                guard let dday = halfProfileUpdate.dday else {
                    descriptionLabel.text = "❤️"
                    return
                }
                distanceDate(dday: dday)
                
            }
        }
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

