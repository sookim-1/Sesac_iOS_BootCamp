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
        
        guard let onboardingVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC else { return }
        
        onboardingVC.modalTransitionStyle = .flipHorizontal
        onboardingVC.modalPresentationStyle = .fullScreen
        
        self.present(onboardingVC, animated: true)
    }
    
}

