//
//  PatientsFoundTableViewCell.swift
//  Max
//
//  Created by Satyam Kumar on 27/02/22.
//

import UIKit

class PatientsFoundTableViewCell: UITableViewCell {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientAge: UILabel!
    @IBOutlet weak var patientMobile: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var messageImage: UIImageView!{
        didSet{
            messageImage.isHidden = true
        }
    }
    @IBOutlet weak var messageCount:UILabel!{
        didSet{
            messageCount.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
