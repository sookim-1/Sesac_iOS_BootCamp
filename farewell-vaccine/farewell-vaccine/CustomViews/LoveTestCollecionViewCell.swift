//
//  LoveTestCollecionViewCell.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import UIKit

class LoveTestCollecionViewCell: UICollectionViewCell {
    static let identifier = String(describing: LoveTestCollecionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideQuestionLabel: UILabel!
    
    func setup(_ slide: LoveTestQuestion) {
        slideImageView.image = slide.image
        slideQuestionLabel.text = slide.question
    }
}
