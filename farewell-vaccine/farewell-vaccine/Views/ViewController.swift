//
//  ViewController.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        if firstLaunch.isFirstLaunch {
            presentOnboardingVC()
        }
        
    }
    
    func presentOnboardingVC() {
        guard let onboardingVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC else { return }
        
        onboardingVC.modalTransitionStyle = .flipHorizontal
        onboardingVC.modalPresentationStyle = .fullScreen
        
        self.present(onboardingVC, animated: true)
    }
    
    @IBAction func presentSideMenu(_ sender: UIButton) {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
}

