//
//  OTPVerificationViewModel.swift
//  Max
//
//  Created by Rahul on 29/12/21.
//

import Foundation
import ProgressHUD

class OTPVerificationViewModel {
    var verifyOtp = VerifyOtp()

    typealias ValidationCompletion = (() -> Void)
    typealias AppointmentCompletion = (() -> Void)

    func verifyOTP(_ otp: String, completion: @escaping AppointmentCompletion) {

        var params = [String: Any]()
        params["otp"] = otp
        params["kind"] = "org"
        params["application_id"] = "\(AuthManager.shared.appTypeId ?? "")"
        params["session_id"] = AuthManager.shared.sessionId

//        params["session_id"] = "1032de0a-3107-4aed-8057-2edb92ce0d63"
        WebServices.verifyOtp(params: params) { response in
            if let response = response {
                if let obj = response.object {
                 self.verifyOtp = obj
                AuthManager.shared.accessToken = obj.access_token
                let profileViewModel = ProfileViewModel()
                profileViewModel.getProfileData {
                }
                completion()
                }
            }
        }
    }

    
  

    func inputOtp(otp: String) {
     verifyOtp.otp = otp
    }

}
