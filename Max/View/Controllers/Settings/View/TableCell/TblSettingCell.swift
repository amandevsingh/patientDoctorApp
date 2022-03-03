//
//  TblSettingCell.swift
//  Max
//
//  Created by Rahul on 05/01/22.
//

import UIKit

class TblSettingCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var vwImageBackGround: UIView!
    @IBOutlet weak var imgSettingType: UIImageView!
    @IBOutlet weak var lblSettingName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(settingViewModel: SettingViewModel,index: Int){
        let settingItem = settingViewModel.getSettingItem(index: index)
        lblSettingName.text = settingItem.name
        //cell.vwImageBackGround.backgroundColor = objItem.color
        //cell.imgSettingType.image = objItem.image
        if index == 0 {
            containerView.layer.cornerRadius = 10
            containerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }else if index == settingViewModel.lastIndex {
            containerView.layer.cornerRadius = 10
            containerView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }else{
        containerView.layer.cornerRadius = 0
        }
    }
}
