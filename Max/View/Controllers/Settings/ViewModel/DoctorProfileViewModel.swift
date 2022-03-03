//
//  DoctorProfileViewModel.swift
//  Max
//
//  Created by aravind  yadav on 13/02/22.
//

import Foundation
import UIKit
class DoctorProfileViewModel {

    private var doctorProfileModel = [DoctorProfileModel]()

    typealias doctorProfileCompletion = (() -> Void)


//     func getDoctorProfileData(completion: @escaping doctorProfileCompletion) {
//        WebServices.getDoctorProfileData() { response in
//            if let response = response {
//               if let arr = response.array {
//                self.doctorProfileModel = arr
//                print(self.doctorProfileModel)
//                   for i in 0..<arr.count {
//                       let dict = arr[i]
//                    AuthManager.shared.doctor_id = dict.id
//                   }
//               completion()
//             }
//           }
//        }
//    }


}
