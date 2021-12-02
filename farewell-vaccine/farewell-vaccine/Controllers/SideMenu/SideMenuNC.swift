//
//  SideMenuNC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/21.
//

import UIKit
import SideMenu

class SideMenuNC: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusBarEndAlpha = 0.0
        self.presentationStyle = .menuSlideIn
        self.menuWidth = self.view.frame.width * 0.5
        self.leftSide = true
    }
    
}
