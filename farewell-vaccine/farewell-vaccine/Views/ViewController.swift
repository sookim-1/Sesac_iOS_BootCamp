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
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        if !localRealm.isEmpty {
            let halfProfile = localRealm.objects(HalfProfile.self)
            nameLabel.text = halfProfile[0].name
        }
        
        if let updateImage = loadImageFromDocumentDirectory(imageName: "profileImage.png") {
            mainImageView.image = updateImage
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
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customPink ?? .systemPink]
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
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
            
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        // 1. 도큐먼트 폴더 경로가져오기
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
        // 2. 이미지 URL 찾기
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            // 3. UIImage로 불러오기
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
}

