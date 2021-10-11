//
//  DrinkWaterViewController.swift
//  iOS-drink-water
//
//  Created by sookim on 2021/10/11.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.title = "물 마시기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: nil)
    }


}

