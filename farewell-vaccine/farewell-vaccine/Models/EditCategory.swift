//
//  EditCategory.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import Foundation
import UIKit


enum EditCategory: CaseIterable {
    case font
    case textColor
    case textSize
    case background
    
}

//["Ultra Light", "Thin", "Light", "Regular", "Medium", "Semibold", "Bold", "Heavy", "Black"]
enum FontWeight: CaseIterable {
    case UltraLight
    case Thin
    case Light
    case Regular
    case Medium
    case Semibold
    case Bold
    case Heavy
    case Black
    
    var kind: String {
        String(describing: self)
    }
}

extension FontWeight {
    var value: UIFont.Weight {
        get {
            switch self {
            case .UltraLight:
                return UIFont.Weight.ultraLight
            case .Thin:
                return UIFont.Weight.thin
            case .Light:
                return UIFont.Weight.light
            case .Regular:
                return UIFont.Weight.regular
            case .Medium:
                return UIFont.Weight.medium
            case .Semibold:
                return UIFont.Weight.semibold
            case .Bold:
                return UIFont.Weight.bold
            case .Heavy:
                return UIFont.Weight.heavy
            case .Black:
                return UIFont.Weight.black
            }
        }
    }
}


// ["빨강", "주황", "노랑", "초록", "파랑", "보라", "검정"]
enum ColorBackground: CaseIterable {
    case 빨강
    case 주황
    case 노랑
    case 초록
    case 파랑
    case 보라
    case 검정
    
    var kind: String {
        String(describing: self)
    }
}

extension ColorBackground {
    var value: UIColor {
        get {
            switch self {
            case .빨강:
                return UIColor.systemRed
            case .주황:
                return UIColor.systemOrange
            case .노랑:
                return UIColor.systemYellow
            case .초록:
                return UIColor.systemGreen
            case .파랑:
                return UIColor.systemBlue
            case .보라:
                return UIColor.systemPurple
            case .검정:
                return UIColor.black
            }
        }
    }
}
