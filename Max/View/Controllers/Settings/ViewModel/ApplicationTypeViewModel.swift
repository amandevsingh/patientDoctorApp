//
//  ApplicationTypeViewModel.swift
//  Max
//
//  Created by aravind  yadav on 12/02/22.
//

import Foundation
import UIKit
import Kingfisher

class ApplicationTypeViewModel {

    private var appTypeModel = [ApplicationTypeModel]()

    typealias appTypeCompletion = (() -> Void)




     func getAPPData(completion: @escaping appTypeCompletion) {
        WebServices.getAppData() { response in
            if let response = response {
               if let arr = response.array {
                self.appTypeModel = arr
                print(self.appTypeModel)
                   for i in 0..<arr.count {
                       let dict = arr[i]
                       if dict.slug == "doctor" {
                           AuthManager.shared.appTypeId = dict.id
                           AuthManager.shared.accId = dict.account_id
                           return
                       }
                   }
               completion()
             }
           }
        }
    }


}
