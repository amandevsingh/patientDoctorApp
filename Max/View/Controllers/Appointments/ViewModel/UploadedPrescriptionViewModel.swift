//
//  UploadedPrescriptionViewModel.swift
//  Max
//
//  Created by aravind  yadav on 28/01/22.
//

import Foundation
import ProgressHUD

class UploadedPrescriptionViewModel {
    private var uploadedPriscription = UploadedPriscriptionModel()

    
   
    var sectionCount: Int {
        uploadedPriscription.items?.count ?? 0
    }
    func getItem(row: Int) -> [ItemsData]? {
        return uploadedPriscription.items
    }


    func rowCount(section: Int) -> Int {
        return uploadedPriscription.items?.count ?? 0
    }

    
    func getPrescriptionData(AppointmentId appointment_id: String,PatientId patient_id: String,completion: @escaping (() -> ())) {
        var params = [String: Any]()

        params["appointment_id"] = appointment_id
        params["patient_id"] = patient_id

        WebServices.getUploadedPrescription(params: params) { response in
            if let response = response {
                if let dict = response.object {
                    
                    self.uploadedPriscription = dict
                    
                completion()
                }
            }
        }
    }
   

}
