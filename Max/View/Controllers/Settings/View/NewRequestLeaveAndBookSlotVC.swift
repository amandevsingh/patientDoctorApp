//
//  NewRequestLeaveAndBookSlotVC.swift
//  Max
//
//  Created by Rahul on 06/01/22.
//

import UIKit

class NewRequestLeaveAndBookSlotVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var consHeightViewMain: NSLayoutConstraint!//530,setview 94
    @IBOutlet var btnCollection: [UIButton]!
    @IBOutlet weak var lblBottominfo: UILabel!
    @IBOutlet weak var vwOn: UIView!
    @IBOutlet var imgCollection: [UIImageView]!//0.From,1.To
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBlur.addSubview(blurredView)
    }
    
    //MARK:-Action
    @IBAction func btnSubmitRequestTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnTypeTapped(_ sender: UIButton) {
        RPicker.pickOption(dataArray: ["Leave","Block Slots"]) { item, index in
            if item == "Leave" {
                self.imgCollection[0].image = #imageLiteral(resourceName: "AppointmentDate")
                self.imgCollection[1].image = #imageLiteral(resourceName: "AppointmentDate")
                self.vwOn.isHidden = true
                self.consHeightViewMain.constant = 530-94
            } else {
                self.imgCollection[0].image = #imageLiteral(resourceName: "AppointmentTime")
                self.imgCollection[1].image = #imageLiteral(resourceName: "AppointmentTime")
                self.vwOn.isHidden = false
                self.consHeightViewMain.constant = 530
            }
            self.btnCollection[0].setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnOnTapped(_ sender: UIButton) {
        RPicker.selectDate(title: "Select New Date", didSelectDate: {[weak self] (selectedDate) in
            self?.btnCollection[1].setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
        })
    }
    
    @IBAction func btnFromTapped(_ sender: UIButton) {
        if btnCollection[0].titleLabel?.text == "Leave" {
            RPicker.selectDate(title: "Select New Date", didSelectDate: {[weak self] (selectedDate) in
                self?.btnCollection[2].setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
            })
        } else {
            RPicker.selectDate(title: "Select New Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
                self?.btnCollection[2].setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            })
        }
    }
    
    @IBAction func btnToTapped(_ sender: UIButton) {
        if btnCollection[0].titleLabel?.text == "Leave" {
            RPicker.selectDate(title: "Select New Date", didSelectDate: {[weak self] (selectedDate) in
                self?.btnCollection[2].setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
            })
        } else {
            RPicker.selectDate(title: "Select New Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
                self?.btnCollection[2].setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            })
        }
    }
}
