//
//  TblAppointmentTypeCell.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class TblAppointmentTypeCell: UITableViewCell {
    
    //MARK:-IBOutlet
    @IBOutlet weak var viewVideoCall: UIView!
    @IBOutlet weak var viewInperson: UIView!
    @IBOutlet weak var lblAppointmentType: UILabel!
    @IBOutlet weak var lblAppointmentNumber: UILabel!
    @IBOutlet weak var lblAppoitmentTiming: UILabel!
    @IBOutlet weak var vwStackAppointmentInfo: UIStackView!
    @IBOutlet weak var lblInPerson: UILabel!
    @IBOutlet weak var lblVideoCallAppointment: UILabel!
    @IBOutlet weak var vwBottomLine: UIView!
    
    var didTapForward: ((Int)->())?


    //MARK:-Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(currentRow:Int,lastIndex: Int,item: Appointments) {
        if currentRow == lastIndex {
        vwBottomLine.isHidden = true
        }else{
        vwBottomLine.isHidden = false
        }
        lblAppoitmentTiming.text = "\(item.slot_start_time ?? "")- \(item.slot_end_time ?? "")"
        
        item.procedures?.forEach({ model in
            if(model.procedure_name == "Video Consultation")||(model.procedure_name == "Instant"){
                lblVideoCallAppointment.text = "\(/model.appointment_count) Video Call"
                viewVideoCall.isHidden =  false
            }
            else if(model.procedure_name == "Consultation"){
                lblInPerson.text = "\(/model.appointment_count) In Person"
                viewInperson.isHidden = false
            }
        })
        
        viewInperson.isHidden = /lblInPerson.text?.count > 0 ? false : true
        viewVideoCall.isHidden = /lblVideoCallAppointment.text?.count > 0 ? false : true
        
        lblAppointmentType.text = item.appointment_type?.uppercased()
        if item.appointment_type?.uppercased() == "OPD"{
            lblAppointmentType.backgroundColor = UIColor.AppThemeDrakBlueColor()
            lblAppointmentNumber.text = "\(item.total_count ?? "0") Appointments"
            vwStackAppointmentInfo.isHidden = false
            lblAppoitmentTiming.isHidden = false

        }else{
            lblAppointmentType.backgroundColor = UIColor.AppThemeGreenColor()
            lblAppointmentNumber.text = "\(item.total_count ?? "0") Admitted Patients"
            vwStackAppointmentInfo.isHidden = true
            lblAppoitmentTiming.isHidden = true
        }


    }
    
    @IBAction func btnForwardTapped(_ sender: UIButton) {
        didTapForward?(self.tag)
    }
}
