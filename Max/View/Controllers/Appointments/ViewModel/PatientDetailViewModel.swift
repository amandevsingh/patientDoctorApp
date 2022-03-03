//
//  PatientDetailViewModel.swift
//  Max
//
//  Created by Ankit on 30/01/22.
//

import Foundation

class PatientDetailViewModel {

    private var prescriptionModel = PrescriptionModel()

    var isnoShowHidden: Bool = false

    func getAppointment(completion: @escaping (()-> ())) {
        var params = [String: Any]()
        params["id"] = "cb8c9ab3-345e-4d55-9246-08b736853779"
        WebServices.getAppointments(params: params) { response in
            if let object = response?.object {
             self.prescriptionModel.no_show_status = (object.latest_status == "no-show")
             self.isnoShowHidden = self.prescriptionModel.no_show_status
             self.prescriptionModel.procedure_Info = object.procedure_info
             self.prescriptionModel.branch_id = object.branch_id ?? ""
             self.prescriptionModel.notes = object.notes
                completion()
            }
        }
    }

    func getNotes() -> [Notes]? {
     return prescriptionModel.notes
    }
    func getBranchID() -> String {
      return prescriptionModel.branch_id
    }

    func getProcedureInfo() -> Procedure_info? {
     return prescriptionModel.procedure_Info
    }

    func getDocument(appointmentID: String,patientID: String,completion: @escaping (() -> ())) {
        var params = [String: Any]()
        params["appointment_id"] = appointmentID
        params["patient_id"] = patientID

        WebServices.getDocument(params: params) { response in

        }
    }

    func getPatientDetail(appointmentID: String,patientID: String,type: String,completion: @escaping (() -> ())) {
        var params = [String: Any]()
        params["appointment_id"] = appointmentID
        params["patient_id"] = patientID
        params["type"] = type
//        let params = [
//            "appointment_id" : "8563bef2-f33c-427f-bfad-62dfb3bc1558",
//            "patient_id" : "841eaf75-9af8-44a4-a823-30a83a795f80",
//            "type" : "PRESCRIPTION"
//        ]
        WebServices.getPrescription(params: params) { response in
            if let response = response {
                if let obj = response.object {
                 self.prescriptionModel = obj
                 completion()
                }
            }
        }
    }
}
