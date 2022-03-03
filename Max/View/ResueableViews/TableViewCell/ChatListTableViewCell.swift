//
//  ChatListTableViewCell.swift
//  Max
//
//  Created by Ankit on 11/02/22.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var personProfileImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var ageAndGenderLabel: UILabel!
    @IBOutlet weak var chatTimeLabel: UILabel!
    @IBOutlet weak var lastVisitLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var chatMessageLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
