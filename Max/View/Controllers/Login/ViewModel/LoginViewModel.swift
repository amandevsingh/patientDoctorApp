//
//  LoginViewModel.swift
//  Max
//
//  Created by Rahul on 23/12/21.
//

import Foundation
import ProgressHUD

class LoginViewModel {
    
    var login = Login()

    typealias ValidationCompletion = (() -> Void)
    typealias OTPCompletion = (() -> Void)

    func loginAttemptOTP(_ mobileNumber: String, completion: @escaping OTPCompletion) {

        var params = [String: Any]()
        params["username"] = mobileNumber
        params["kind"] = "org"
        params["country_code"] = "+91"
        params["account_id"] = AuthManager.shared.accId
        WebServices.loginWithOTP(params: params) { response in
            if let response = response {
                if let obj = response.object {
                 self.login = obj
                AuthManager.shared.sessionId = obj.session_id
                 completion()
                }
            }
        }
    }

    func inputCountryCode(countryCode: String) {
        login.countryCode = countryCode
    }

    func inputMobileNumber(mobileNumber: String) {
     login.mobileNumber = mobileNumber
    }

}
