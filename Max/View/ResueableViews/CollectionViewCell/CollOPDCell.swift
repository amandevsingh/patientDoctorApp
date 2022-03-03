//
//  CollOPDCell.swift
//  Max
//
//  Created by Rahul on 17/12/21.
//

import UIKit

class CollOPDCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblType: UILabel!

    func setupCell(type: (CollectionViewTitleEnum,Int?)) {
        lblType.text = type.0.rawValue
        lblCount.text = "\(type.1 ?? 0)"
    }
}
