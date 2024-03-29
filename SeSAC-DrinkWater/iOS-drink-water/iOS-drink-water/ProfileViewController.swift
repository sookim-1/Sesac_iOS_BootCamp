//
//  ProfileViewController.swift
//  iOS-drink-water
//
//  Created by sookim on 2021/10/11.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileDescriptionLabel: [UILabel]!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setProfileDescriptionLabel()
        profileImage.image = UIImage(named: "1-6")
    }
    
    private func setProfileDescriptionLabel() {
        for i in profileDescriptionLabel {
            i.textColor = .white
            i.font = .preferredFont(forTextStyle: .body)
            i.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setNavigationBar() {
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.backgroundColor = UIColor(red: 79/255, green: 158/255, blue: 127/255, alpha: 1.0)
        self.navigationItem.standardAppearance = barAppearance
        self.navigationItem.scrollEdgeAppearance = barAppearance
        
        self.title = "물 마시기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveProfile))
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = UIColor(red: 156/255, green: 203/255, blue: 184/255, alpha: 1.0)
    }
    
    @objc func saveProfile() {
        guard let nickname = nicknameTextField.text,
              let heightString = heightTextField.text,
              let height = Double(heightString),
              let weightString = weightTextField.text,
              let weight = Double(weightString) else { return }
        
        let profileModel = ProfileModel(nickname: nickname, height: height, weight: weight)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(profileModel), forKey: "profileModel")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
