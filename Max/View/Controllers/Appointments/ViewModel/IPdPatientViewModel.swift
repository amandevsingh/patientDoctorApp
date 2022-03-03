//
//  IPdPatientViewModel.swift
//  Max
//
//  Created by aravind  yadav on 26/01/22.
//

import Foundation
import ProgressHUD

class IPdPatientViewModel {
    private var ipdPatient = [IpdData]()

    var sectionCount: Int {
        ipdPatient.count
    }

    typealias ValidationCompletion = (() -> Void)
    typealias AppointmentCompletion = (() -> Void)

//    func titleForSection(section: Int) -> String {
//        ipdPatient[section].branch_name ?? ""
//    }

    func rowCount(section: Int) -> Int {
      return ipdPatient.count
    }

    func getPatientPii(section: Int,row: Int) -> Pii? {
    return ipdPatient[row].patient?.pii
    }


    //DoctorID: "4c686467-59ed-4f13-8ab0-9563642b930d",
    func getIpDPatient(BranchId branch_id: String,IpdDate ipd_date: String, completion: @escaping AppointmentCompletion) {

        var params = [String: Any]()
        params["doctor_id"] = AuthManager.shared.doctor_id
        params["ipd_date"] = ipd_date
        params["branch_id"] = branch_id

        WebServices.getIpdPatientt(params: params) { response in
            if let response = response {
                if let arr = response.array {
                 self.ipdPatient = arr
                 completion()
                }
            }
        }
    }

    func inputOtp(otp: String) {
//     verifyOtp.otp = otp
    }

}
