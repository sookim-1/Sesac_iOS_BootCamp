//
//  EditCell.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/23.
//

import UIKit

class EditCell: UICollectionViewCell {
    static let reuseID = "EditCell"
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCategory(categoryImageListView: ImageListView) {
        let imageListView = categoryImageListView
        
        addSubview(imageListView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            imageListView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            imageListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }

}
