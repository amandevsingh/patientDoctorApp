//
//  SelectDoctorsTableViewCell.swift
//  Max
//
//  Created by Satyam Kumar on 27/02/22.
//

import UIKit

class SelectDoctorsTableViewCell: UITableViewCell {
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorDetailsLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
