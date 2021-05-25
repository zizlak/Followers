//
//  UIHelper.swift
//  Followers
//
//  Created by Aleksandr Kurdiukov on 18.05.21.
//

import UIKit

enum UIHelper {
    
    static func create3ColumnFlowlayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (spacing * 2)
        let itemWidth = availableWidth / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.minimumLineSpacing = spacing
        
        return layout
    }
}
