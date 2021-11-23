//
//  ImageListView.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

class ImageListView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureDefault()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(category: EditCategory, itemImage: UIImage?, itemColor: UIColor = .systemBackground) {
        super.init(frame: .zero)
        
        configureCategory(category, itemImage, itemColor: itemColor)
    }
    
    private func configureDefault() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: "logo")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCategory(_ category: EditCategory, _ itemImage: UIImage?, itemColor: UIColor = .systemBackground) {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        switch category {
        case .font:
            image = itemImage
        case .textColor:
            backgroundColor = itemColor
        case .background:
            image = itemImage
        }
    }
    
}
