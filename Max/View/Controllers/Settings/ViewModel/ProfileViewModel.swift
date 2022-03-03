//
//  ProfileViewModel.swift
//  Max
//
//  Created by Ankit on 26/01/22.
//

import Foundation
import UIKit
import Kingfisher

class ProfileViewModel {

    private var profile = UserProfileModel()

    typealias ProfileCompletion = (() -> Void)


    var getUserImage : UIImage? {
    return UIImage()
    }

    var getUserName : String? {
     return profile.name ?? ""
    }
    var getUserMobileNumber: String? {
        return profile.mobile != nil ? "\(profile.country_code ?? "")-\(profile.mobile ?? "")" : ""
    }
    var getExperience : String? {
        return "\(profile.qualification ?? "MBBS") \n \(profile.designation ?? "Senior Consultant") | 15 yrs+ Experience"
        //return "MBBS \n Senior Consultant  |  15yrs+ Experience"
    }

    var speciality: String? {
        return profile.specialities ?? "Null"
    }

    var emailId: String? {
        return profile.email ?? ""
    }

    var getSupportMobileNumber: String? {
     return ""
    }

     func getProfileData(completion: @escaping ProfileCompletion) {
        WebServices.getProfileData { response in
            if let response = response {
               if let obj = response.object {
                self.profile = obj
                print(self.profile)
               AuthManager.shared.doctor_id  =  obj.id
               AuthManager.shared.userData = obj
               completion()
             }
           }
        }
    }


}



