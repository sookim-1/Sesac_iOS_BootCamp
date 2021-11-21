//
//  ViewController.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSettingBtn()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentOnboardingVC()
        }
        
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

//        let barAppearance = UINavigationBarAppearance()
//
//        barAppearance.backgroundColor = .white
//        self.navigationItem.standardAppearance = barAppearance
//        self.navigationItem.scrollEdgeAppearance = barAppearance
        
        self.title = "이별백신"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        self.navigationController?.navigationBar.tintColor = .systemBlue

    }
    
    func presentOnboardingVC() {
        guard let onboardingVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC else { return }
        
        onboardingVC.modalTransitionStyle = .flipHorizontal
        onboardingVC.modalPresentationStyle = .fullScreen
        
        self.present(onboardingVC, animated: true)
    }
    
    func configureSettingBtn() {
        settingButton.backgroundColor = UIColor(red: 254/255, green: 107/255, blue: 160/255, alpha: 1)
        settingButton.setTitleColor(.white, for: .normal)
        settingButton.setTitle("지정하기", for: .normal)
        settingButton.layer.cornerRadius = 10
    }
            
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
}

