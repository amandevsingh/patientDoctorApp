//
//  OpdPatientViewModel.swift
//  Max
//
//  Created by aravind  yadav on 26/01/22.
//

import Foundation
import ProgressHUD

enum CollectionViewTitleEnum: String {
    case checked_in = "Checked-In"
    case total_appts = "Total Appts"
    case no_Show_Cancel = "No Show/Cancel"
    case checked_out = "Checked-Out"
}

class OpdPatientViewModel {

    private var opdPatientModel = [OPDDataModel]()
    private var doctorSlotConfigModel = DoctorSlotConfigModel()
    /*
     https://medi.hlthclub.in/vault/v1/appointments?appointment_date=2022-01-31&branch_id=3d215223-8126-4c71-9214-eb263a40c150
     */

    var getOPDPatientCount : Int {
        return opdPatientModel.count
    }

    var getCollectionViewTitle: [(CollectionViewTitleEnum,Int?)] {

        return [(.checked_in,0),(.total_appts,opdPatientModel.count),(.no_Show_Cancel,0),(.checked_out,0)]
    }

    func getTableViewRowCount(selectedIndex: CollectionViewTitleEnum) -> Int {

        switch selectedIndex {
            case .checked_in:
                return 0
            case .total_appts:
                return opdPatientModel.count
            case .no_Show_Cancel:
                return 0
            case .checked_out:
                return 0
        }
    }

    func getAppointmentID(index: Int) -> String {
    return opdPatientModel[index].id ?? "0"
    }

    func getPatientName(index: Int) -> String {
    return opdPatientModel[index].patient?.pii?.name ?? ""
    }

    func getPatientMobileNumber(index: Int) -> String {
    return opdPatientModel[index].patient?.pii?.mobile ?? ""
    }

    private func getAge(index: Int) -> String {
        let dateString = "\(opdPatientModel[index].patient?.birth_year ?? 0)-01-01"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        let dateComponent = Calendar.current.dateComponents([.year], from: date,to: Date())
        return "\(dateComponent.year ?? 0)"
    }

    private func getGender(index: Int) -> String {
        return opdPatientModel[index].patient?.genderMaster?.name?.lowercased() == "male" ? "M" : "F"
    }

    func getFormattedAgeAndGender(index: Int) -> String {
        return "(\(getAge(index: index)),\(getGender(index: index)))"
    }

    func getOPDPatient(index: Int) ->  Pii {
        return opdPatientModel[index].patient?.pii ?? Pii()
    }
    func getOPDData(BranchId branch_id: String,OpdDate opd_date: String,completion: @escaping (() -> ())) {
        var params = [String: Any]()

        params["appointment_date"] = opd_date
        params["branch_id"] = branch_id

        WebServices.getOPD(params: params) { response in
            if let response = response {
                if let arr = response.array {
                self.opdPatientModel = arr
                completion()
                }
            }
        }
    }
    func rowCount(section: Int) -> Int {
      return opdPatientModel.count
    }
    
    
    
    func getDoctorSlotConfig(doctorSlotConfigId doctor_slot_config_id: String,completion: @escaping (() -> ())) {
        var params = [String: Any]()
        params["doctor_slot_config_id"] = doctor_slot_config_id

        WebServices.getDoctorslotConfig(doctor_slot_config_id: doctor_slot_config_id) { response in
            if let response = response {
                if let obj = response.object {
                self.doctorSlotConfigModel = obj
                completion()
                }
            }
        }
    }
    
    var getPractice_status : String {
        return doctorSlotConfigModel.practice_status ?? ""
    }
    
    
    func getPracticeUpdate(doctorSlotConfigId doctor_slot_config_id: String,practiceStatus practice_status : String ,completion: @escaping (() -> ())) {
        var params = [String: Any]()
        params["doctor_slot_config_id"] = doctor_slot_config_id
        params["practice_status"] = practice_status

        WebServices.getPracticeUpdate(params: params) { response in
            if response == true {
//                if case let obj == response {
//                self.doctorSlotConfigModel = obj
                completion()
//                }
            }
        }
    }

}
