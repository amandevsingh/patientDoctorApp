//
//  RescheduleAppointmentPopUpVC.swift
//  Max
//
//  Created by Rahul on 30/12/21.
//

import UIKit

class RescheduleAppointmentPopUpVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!

    let rescheduleAppointmentViewModel = RescheduleAppointmentViewModel()
    var id: ((branch_id: String,procedure_info: Procedure_info?)) = (branch_id: "",procedure_info: Procedure_info())
    var completion: ((Bool) -> ())?

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rescheduleAppointmentViewModel.setBranchID(id: id.branch_id)
        rescheduleAppointmentViewModel.setProcedureID(procedure_Info: id.procedure_info)
        rescheduleAppointmentViewModel.setProcedureName(procedure_Info: id.procedure_info)
        self.vwBlur.addSubview(blurredView)
        self.rescheduleAppointmentViewModel.getSlots {
         self.btnDate.setTitle(self.rescheduleAppointmentViewModel.selectedDateInString(), for: .normal)
            if let slots = self.rescheduleAppointmentViewModel.getSlots() {
             self.rescheduleAppointmentViewModel.setSelectedSlot(index: 0)
             self.btnTime.setTitle(slots.first, for: .normal)
            }else {
            self.btnTime.setTitle("Select A Time", for: .normal)
            }
        }
    }
    
    //MARK:-Action
    @IBAction func btnDatePickerTapped(_ sender: UIButton) {
        self.btnTime.setTitle("Please select a time", for: .normal)
        rescheduleAppointmentViewModel.setSelectedSlotToNil()

        RPicker.selectDate(title: "Select New Date", cancelText: "Cancel", doneText: "Done", datePickerMode: .date, selectedDate: Date(), minDate: Date(), maxDate: Date().dateByAddingYears(25), style: .Wheel) {[weak self] (selectedDate) in
            self?.rescheduleAppointmentViewModel.setSelectedDate(date: selectedDate)
            self?.btnDate.setTitle(self?.rescheduleAppointmentViewModel.selectedDateInString(), for: .normal)
            self?.rescheduleAppointmentViewModel.getSlots {
                if let slots = self?.rescheduleAppointmentViewModel.getSlots() {
                 self?.rescheduleAppointmentViewModel.setSelectedSlot(index: 0)
                 self?.btnTime.setTitle(slots.first, for: .normal)
                }else {
                self?.btnTime.setTitle("Select A Time", for: .normal)
                }
            }
        }
    }
    
    @IBAction func btnTimePickerTapped(_ sender: UIButton) {

        let time = rescheduleAppointmentViewModel.getSlots()
        if time?.count ?? 0 > 0{
        RPicker.selectOption(title: "Select New Time", cancelText: "Cancel", doneText: "Done", dataArray: time, selectedIndex: 0) { [weak self] value, atIndex in
            self?.btnTime.setTitle(value, for: .normal)
            self?.rescheduleAppointmentViewModel.setSelectedSlot(index: atIndex)
        }
        }
    }
    
    @IBAction func btnRescheduleTapped(_ sender: UIButton) {
        rescheduleAppointmentViewModel.rescheduleAppointment {
            self.dismiss(animated: true) {
            self.completion?(true)
            }
        }
    }

}
