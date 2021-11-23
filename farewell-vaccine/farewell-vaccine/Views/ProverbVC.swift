//
//  ProverbVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/22.
//

import UIKit

class ProverbVC: UIViewController {

    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        randomAdvice()
    }
    
    func randomAdvice() {
        let jsonDecoder = JSONDecoder()
        guard let adviceItemsData = NSDataAsset(name: "items")
        else { return }
        
        do {
            let advices: [LoveAdvice] = try jsonDecoder.decode([LoveAdvice].self, from: adviceItemsData.data)
            guard let advice = advices.randomElement() else { return }
            adviceLabel.text = "\(advice.advice) - \(advice.author)"
        } catch  {
            print("Error")
        }
    }
    
    func configureNavigationBar() {
        self.title = "명언"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customPink]
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(presentSideMenu))
        menuButton.tintColor = .customPink
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func presentSideMenu() {
        guard let sideMenuNC = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNC") as? SideMenuNC else { return }
        
        self.present(sideMenuNC, animated: true)
    }
}
