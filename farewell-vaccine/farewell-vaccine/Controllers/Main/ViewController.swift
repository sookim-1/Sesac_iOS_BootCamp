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
        try! localRealm.write {
            if !localRealm.isEmpty {
                let halfProfile = localRealm.objects(HalfProfile.self)
                nameLabel.text = halfProfile[0].name
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentOnboardingVC()
        }
    }
    
    func configureNavigationBar() {        
        self.title = "이별백신"
    }
    
    func configureImageView() {
        mainImageView.contentMode = UIView.ContentMode.scaleAspectFill
        mainImageView.layer.cornerRadius = 100
        mainImageView.clipsToBounds = true
        mainImageView.layer.borderWidth = 10
        mainImageView.layer.borderColor = UIColor.customPink?.cgColor
    }
    
    func presentOnboardingVC() {
        guard let onboardingVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC else { return }
        
        onboardingVC.modalTransitionStyle = .crossDissolve
        onboardingVC.modalPresentationStyle = .fullScreen
        
        self.present(onboardingVC, animated: true)
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

