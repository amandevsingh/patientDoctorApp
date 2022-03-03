//
//  PermissionsTblswift
//  Max
//
//  Created by Rahul on 05/01/22.
//

import UIKit

class PermissionsTblCell: UITableViewCell {

    @IBOutlet weak var imgSelectionMark: UIImageView!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var btnStartChat: UIButton!
    @IBOutlet weak var btnEndChat: UIButton!
    @IBOutlet weak var btnPerVideoLimit: UIButton!
    
    var startChat: ((String,Int)->())?
    var endChat: ((String,Int)->())?
    var videoLimit: ((String,Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data: PermissionItem) {
        lblNotification.text = data.title
        imgSelectionMark.backgroundColor = data.color
        imgSelectionMark.image = data.image
        btnStartChat.setTitle(data.startChat, for: .normal)
        btnEndChat.setTitle(data.endChat, for: .normal)
        btnPerVideoLimit.setTitle(data.videoLimit, for: .normal)
    }
    
    @IBAction func btnStartChatTapped(_ sender: UIButton) {
        RPicker.pickOption(dataArray: ["0 Hours","10 Hours","48 Hours"]) { item, index in
            self.startChat?(item,index)
            self.btnStartChat.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnEndChatTapped(_ sender: UIButton) {
        RPicker.pickOption(dataArray: ["0 Hours","10 Hours","48 Hours"]) { item, index in
            self.endChat?(item,index)
            self.btnEndChat.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnVideiLimitTapped(_ sender: UIButton) {
        RPicker.pickOption(dataArray: ["1","3","5"]) { item, index in
            self.videoLimit?(item,index)
            self.btnPerVideoLimit.setTitle(item, for: .normal)
        }
    }
}
