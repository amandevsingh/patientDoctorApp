//
//  TblIPDPatientsCell.swift
//  Max
//
//  Created by Rahul on 17/12/21.
//

import UIKit

class TblIPDPatientsCell: UITableViewCell {
    
    //MARK:-IBOutlet
    @IBOutlet weak var imgPatient: UIImageView!
    @IBOutlet weak var lblPatientsShortName: UILabel!
    @IBOutlet weak var lblPatientsName: UILabel!
    @IBOutlet weak var lblPatientsAge: UILabel!
    @IBOutlet weak var vwTag: TagCollection!
    
    var didTapForward: ((Int)->())?

    //MARK:-Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        
    }
    
    @IBAction func btnForwardTapped(_ sender: UIButton) {
        didTapForward?(self.tag)
    }
}
