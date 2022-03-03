//
//  AppointmentHeaderViewTableViewCell.swift
//  Max
//
//  Created by Ankit on 25/01/22.
//

import UIKit

class AppointmentHeaderViewTableViewCell: UITableViewCell {

    @IBOutlet weak var appointmentHeaderView : UIView!{
        didSet{
        appointmentHeaderView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
    }
    @IBOutlet weak var appointmentHeaderLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
