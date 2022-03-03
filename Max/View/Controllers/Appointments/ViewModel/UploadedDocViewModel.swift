//
//  UploadedDocViewModel.swift
//  Max
//
//  Created by aravind  yadav on 01/02/22.
//

import Foundation

class UploadedDocViewModel {
private var uploadedDoc = UploadedDocModel()

    

    var getResult: String {
        uploadedDoc.result ?? ""
    }

    
    func getDocData(DataId data_id: String,completion: @escaping (() -> ())) {
       
        WebServices.getDocData(params: data_id) { response in
            if let response = response {
                if let dict = response.object {
                    
                    self.uploadedDoc = dict
                    
                completion()
                }
            }
        }
    }
   

}
