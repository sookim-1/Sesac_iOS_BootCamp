//
//  UIViewController+Ext.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

extension UIViewController {
    func presentModalFullstyle(storyboardName: String, storyboardIdentifier: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}
