//
//  AppointmentViewModel.swift
//  Max
//
//  Created by aravind  yadav on 24/01/22.
//

import Foundation
import ProgressHUD

class AppointmentViewModel {
    private var appointment = [AppointmentModel]()

    var sectionCount: Int {
        appointment.count
    }

    typealias ValidationCompletion = (() -> Void)
    typealias AppointmentCompletion = (() -> Void)

    func titleForSection(section: Int) -> String {
    appointment[section].branch_name ?? ""
    }
    
    func branchId(section: Int) -> String {
    appointment[section].branch_id ?? ""
    }
    func ipdDate(section: Int) -> String {
    appointment[section].appointment_date ?? ""
    }

    func rowCount(section: Int) -> Int {
      return appointment[section].appointments?.count ?? 0
    }

    func requestItem(section: Int,row: Int) -> Appointments? {
        return appointment[section].appointments?[row]
    }

    //DoctorID: "4c686467-59ed-4f13-8ab0-9563642b930d",
    func getAppointment(AppointmentDate appointment_date: String,BranchWiseCount branch_wise_count: Bool, completion: @escaping AppointmentCompletion) {

        var params = [String: Any]()
        params["doctor_id"] = AuthManager.shared.doctor_id
        params["appointment_date"] = appointment_date
        params["branch_wise_count"] = branch_wise_count

        WebServices.getAppointment(params: params) { response in
            if let response = response {
                if let obj = response.object {
                    self.appointment = obj.items!
                 completion()
                }
            }
        }
    }

    func inputOtp(otp: String) {
//     verifyOtp.otp = otp
    }

}
