//
//  CustomPinkButton.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

class CustomPinkButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .customPink
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }
    
}
