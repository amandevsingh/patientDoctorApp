//
//  VisitsTableViewCell.swift
//  Max
//
//  Created by Satyam Kumar on 27/02/22.
//

import UIKit

class VisitsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var statusLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
