//
//  SideMenuVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/21.
//

import UIKit

class SideMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customPink
    }
    
    @IBAction func presentHomeNC() {
        presentModalFullstyle(storyboardName: "Main", storyboardIdentifier: "HomeNC")
    }
    
    @IBAction func presentIntroduceNC() {
        presentModalFullstyle(storyboardName: "Introduce", storyboardIdentifier: "IntroduceNC")
    }
    
    @IBAction func presentFVTestNC() {
        presentModalFullstyle(storyboardName: "FVTest", storyboardIdentifier: "FVTestNC")
    }
    
    @IBAction func presentProverbNC() {
        presentModalFullstyle(storyboardName: "Proverb", storyboardIdentifier: "ProverbNC")
    }
    
    @IBAction func presentProfileNC() {
        presentModalFullstyle(storyboardName: "Profile", storyboardIdentifier: "ProfileNC")
    }
    
    @IBAction func presentSettingNC() {
        presentModalFullstyle(storyboardName: "Setting", storyboardIdentifier: "SettingNC")
    }
    
    
}
