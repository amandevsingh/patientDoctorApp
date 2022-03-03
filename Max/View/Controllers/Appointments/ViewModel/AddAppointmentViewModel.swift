//
//  AddAppointmentViewModel.swift
//  Max
//
//  Created by Rahul on 28/12/21.
//

import Foundation
import ObjectMapper
import SwiftUI
import CoreMedia



class AddAppointmentViewModel {

    private var addAppointmentModel = AddAppointmentModel()
    private var dispatchGroup = DispatchGroup()

    func checkAddPatientValidation(_ firstName: String, _ lastName: String, _ phoneNumber: String, emailID: String, _ completion: @escaping ValidationCompletion) {
        let value = Validation.shared.validateAddPatientDetails(firstName, lastName, phoneNumber, emailID: emailID)
        switch value {
        case .success:
            completion("",true)
        case .failure(let str):
            completion(str,false)
        }
    }

    func getDepartment(name: String,code: String,branchId: String,externalID:String,isActive: Bool,branchExternalID: String,completion: @escaping (() -> Void)) {
        var params = [String: Any]()
        params["name"] = name
        params["code"] = code
        params["branch_id"] = branchId
        params["external_id"] = externalID
        params["is_active"] = isActive
        params["branch_external_id"] = branchExternalID

        WebServices.getDepartment(params: params) { response in
        }
    }

    func getSlots(date: String,completion: @escaping (() -> Void)) {
       var params = [String: Any]()
        params["doctor_id"] = AuthManager.shared.doctor_id //"4c686467-59ed-4f13-8ab0-9563642b930d"//
        params["branch_id"] = addAppointmentModel.selectedHospitalBranchItem?.id
        //"3d215223-8126-4c71-9214-eb263a40c150"//branchID
        params["procedure_id"] = addAppointmentModel.selectedAppointment?.id
            //"c1cecec2-b018-4ea9-b11d-5223edf44f8e" //procedureID
        params["slot_date"] =  date //"2022-02-07"

        WebServices.getAvailableSlots(params: params) { response in
            if let response = response {
                if let obj = response.object {
                 self.addAppointmentModel.slot = obj
                  completion()
                }
            }
        }
    }


     func getBranch(completion: @escaping (() -> Void)){
        WebServices.getBranchList { response in
            if let response = response {
                if let obj = response.object {
                self.addAppointmentModel.branch = obj
                completion()
                }
            }
        }
    }

    func getNationality(completion: @escaping (() -> Void)){
        WebServices.getNationality { response in
            if let response = response{
                if let arr = response.array {
                self.addAppointmentModel.nationalityList = arr
                completion()
                }
            }
        }
    }

    func getProcedures(completion: @escaping (() -> Void)) {
        WebServices.getProcedures { response in
            if let response = response {
                if let arr = response.array {
                self.addAppointmentModel.procedures = arr
                completion()
                }
            }
        }
    }

    func getPatientsByMobileNumber(mobileNumber: String,completion: @escaping (() -> Void)) {
        var params = [String: Any]()
        params["mobile"] = mobileNumber//"7777777777"
        WebServices.getPatientsByMobile(params: params) { response in
            if let response = response {
                if let arr = response.array {
                    self.addAppointmentModel.patients = arr
                    completion()
                }
            }
        }
    }

    func getCurrentDate() -> String {
        let date = Date()
        return date.dateString("d MMM yy")
    }

    func setNewPatientMobileNumber(mobileNumber: String) {
    addAppointmentModel.newPatientPhoneNumber = mobileNumber
    }

    func setNewPatientDateOfBirth(dob: Date) {
     addAppointmentModel.newPatientDOB = dob
    }

    func setNewPatientEmailID(email: String) {
    addAppointmentModel.newPatientEmailID = email.lowercased()
    }

    func setNewPatientFirstName(name: String) {
        addAppointmentModel.newPatientFirstName = name
    }

    func setNewPatientLastName(name: String) {
        addAppointmentModel.newPatientLastName = name
    }

    func getAgeFromDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        if let newPatientDOB = addAppointmentModel.newPatientDOB {
        return dateFormatter.string(from: newPatientDOB)
        }
        return nil
    }

    func addPatient(completion: @escaping (() -> Void)) {
        var params = [String: Any]()
        
        params["address"] = "hhdhhhdhd"
        params["age"] = getAgeFromDate()  //"1990"
        params["email"] = addAppointmentModel.newPatientEmailID //"e@gmail.com"
        params["first_name"] = addAppointmentModel.newPatientFirstName//"eee"
        params["gender_id"] = addAppointmentModel.selectedGender?.id//"ba03c27e-2af3-4792-8949-ab01bea0d069"
        params["last_name"] = addAppointmentModel.newPatientLastName //"nnnn"
        params["mobile"] = addAppointmentModel.newPatientPhoneNumber //"7777777777"
       // params["patient_type"] = ""

        WebServices.addPatient(params: params) { response in
            if let response = response {
               if response.statusCode == 200 {
                   self.resetNewPatientDetail()
                   completion()
               }
            }
        }
    }

    func resetNewPatientDetail() {
        addAppointmentModel.newPatientEmailID = nil
        addAppointmentModel.newPatientFirstName = nil
        addAppointmentModel.newPatientLastName = nil
        addAppointmentModel.newPatientPhoneNumber = nil
        addAppointmentModel.newPatientDOB = nil
    }

    func getGender(completion: @escaping (() -> Void)) {
        WebServices.getGender { response in
            if let response = response {
                if let arr = response.array {
                self.addAppointmentModel.gender = arr
                completion()
                }
            }
        }
    }

    func getPatientList() -> [String]? {
        var patients = [String]()
        for item in addAppointmentModel.patients ?? [] {
            patients.append(item.name ?? "null")
        }
        patients.append("+ Add New Patient")
        return patients
    }

    func getBranchList() -> [String]? {
        var branches = [String]()
        for item in addAppointmentModel.branch?.items ?? [] {
         branches.append(item.name ?? "")
        }
        return branches
    }

    func getSlots() -> [String]? {
        var availableSlots = [String]()
        for item in addAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots ?? [] {
            availableSlots.append((item.s_time ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return availableSlots
    }

    func getNationality() -> [String]? {
        var nations = [String]()
        for nation in addAppointmentModel.nationalityList ?? [] {
            nations.append(nation.name ?? "")
        }
        return nations
    }

    func getProcedures() -> [String]? {
        var appointmentTypes = [String]()
        for appointmentType in addAppointmentModel.procedures ?? [] {
            appointmentTypes.append(appointmentType.name ?? "")
        }
     return appointmentTypes 
    }

    func getGenders() -> [String]? {
        var genders = [String]()
        for gender in addAppointmentModel.gender ?? [] {
            genders.append(gender.name?.capitalized ?? "null")
        }
        return genders
    }

    func setSelectedBranch(index: Int) {
        if addAppointmentModel.branch?.items?.count ?? 0 > 0 {
        addAppointmentModel.selectedHospitalBranchItem = addAppointmentModel.branch?.items?[index]
        }
    }

    func setSelectedAppointment(index: Int) {
        if addAppointmentModel.procedures?.count ?? 0 > 0{
        addAppointmentModel.selectedAppointment = addAppointmentModel.procedures?[index]
        }
    }

    func setSelectedSlotToNil(){
        addAppointmentModel.selectedSlot = nil
    }

    func setSelectedSlot(index: Int) {
        if addAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots?.count ?? 0 > 0 {
            addAppointmentModel.selectedSlot = addAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots?[index]
        }
    }

    func setSelectedPatient(index: Int) {
        if addAppointmentModel.patients?.count ?? 0 > 0 {
            addAppointmentModel.selectedPatient = addAppointmentModel.patients?[index]
        }
    }

    func setSelectedGender(index: Int) {
        if addAppointmentModel.gender?.count ?? 0 > 0 {
            addAppointmentModel.selectedGender = addAppointmentModel.gender?[index]
        }
    }

    func setSelectedNation(index: Int) {
        if addAppointmentModel.nationalityList?.count ?? 0 > 0 {
            addAppointmentModel.selectedNation = addAppointmentModel.nationalityList?[index]
        }
    }

    /*
     branch_id: "3d215223-8126-4c71-9214-eb263a40c150"
     doctor_id: "4c686467-59ed-4f13-8ab0-9563642b930d"
     patient_id: null
     procedure_id: "c1cecec2-b018-4ea9-b11d-5223edf44f8e"
     slot_id: "1d02515e-df23-402a-aec1-ebcf74b2ae9c"
     source: "Web"
     */
    func addAppointment(completion: @escaping (() -> Void)){
        var params = [String: Any]()
        params["branch_id"] = addAppointmentModel.selectedHospitalBranchItem?.id//branchID
        params["doctor_id"] = AuthManager.shared.doctor_id//doctorID
        params["patient_id"] = addAppointmentModel.selectedPatient?.id//patientID
        params["procedure_id"] = addAppointmentModel.selectedAppointment?.id//procedureID
        params["slot_id"] = addAppointmentModel.selectedSlot?.slot_id//slotID
        params["source"] = "Web"
        params["date"] = ""
        WebServices.addAppointment(params: params) { response in
            if let response = response {

            completion()
            }
        }
    }
}


