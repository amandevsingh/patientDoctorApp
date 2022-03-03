//
//  CommonContants.swift
//  Max
//
//  Created by Rahul on 13/12/21.
//

import UIKit

let KScreenSize = UIScreen.main.bounds.size
let KAppDelegate = (UIApplication.shared.delegate as! AppDelegate)

typealias APIResult = Result<Bool, Error>
typealias APICompletion = (_ result: APIResult) -> Void

//Storyboard
let dashboardStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
let myPatientsStoryboard = UIStoryboard(name: "MyPatients", bundle: nil)
let analyticsStoryboard = UIStoryboard(name: "Analytics", bundle: nil)
let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
let supportStoryboard = UIStoryboard(name: "Support", bundle: nil)

//MARK: Message Constant
struct KString {
    static let strAppHeader = "Max!!"
    static let layerName = "GradientMax"
}

struct KAlertString {
    static let success = "success"
    static let error = "Error"
    static let verifying = "Verifying..."
    static let otpSuccess = "OTP Verified"
    static let wrongOtp = "Wrong OTP"
}


