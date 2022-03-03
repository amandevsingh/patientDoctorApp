//
//  TblOPDPatientsCell.swift
//  Max
//
//  Created by Rahul on 17/12/21.
//

import UIKit

class TblOPDPatientsCell: UITableViewCell {

    //MARK:-IBOutlet
    @IBOutlet weak var lblPatientsShortName: UILabel!
    @IBOutlet weak var imgPatient: UIImageView!
    @IBOutlet weak var lblPatientsName: UILabel!
    @IBOutlet weak var lblPatientsAge: UILabel!
    @IBOutlet weak var vwTag: TagCollection!
    @IBOutlet weak var lblAppointmentTime: UILabel!
    @IBOutlet weak var btnAppointDuration: UIButton!
    @IBOutlet weak var lblSpecialPatient: UILabel!
    
    var didTapVideo: ((Int)->())?

    //MARK:-Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        
    }
    
    @IBAction func btnVideoTapped(_ sender: UIButton) {
        didTapVideo?(self.tag)
    }
}
