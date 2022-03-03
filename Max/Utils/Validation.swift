//
//  Validation.swift
//  Max
//
//  Created by Rahul on 27/12/21.
//

import UIKit

typealias ValidationCompletion = (String,Bool)->()

//for failure and success results
enum ErrorAlert {
    case success
    case failure
    case error
}

//for success or failure of validation with alert message
enum isValid {
    case success
    case unknown
    case failure(ErrorAlert, AlertMessages)
}

enum Valid {
    case success
    case failure(String)
}

enum SwiftAlertType: Int {
    case error
    case info
    case success
    case otp
}

enum DismissAlert: String {
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case locationPermission = "Location Permissions"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case info = "Warning"
    case confirmation = "Confirmation"
    
    func showWithType(type : DismissAlert? = .info, message : String) {
        alertMessase(message: message, okAction: {})
    }
}


let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
let phoneRegex = "^[0-9]{6,15}$"
let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
let passwordRegex = "[A-Z0-9a-z._%@+-]{6,15}"
let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
let idValidation = "[A-Z0-9a-z._%@+-/*]{3,20}"
let idTest = NSPredicate(format: "SELF MATCHES %@", idValidation)

enum AlertMessages: String {
    case inValidEmail = "Please a enter valid email id"
    case inValidPhone = "Please enter a valid mobile Number"
    case invalidAddress = "Please enter valid Email Adddress"
    case emptyPhone = "Please enter mobile Number"
    case emptyEmail = "Please enter Email Id"
    case emptyFirstName = "Please enter First Name"
    case emptyLastName = "Please enter Last Name"
}

class Validation: NSObject {
    
    public static let shared = Validation()
    
    //MARK:-Add Patient
    func validateAddPatientDetails(_ firstName: String, _ lastName: String, _ phoneNumber: String, emailID: String) -> Valid {
        if (firstName.trim().isEmpty) {
            return .failure(AlertMessages.emptyFirstName.rawValue.localized())
        }
        if (lastName.trim().isEmpty) {
            return .failure(AlertMessages.emptyLastName.rawValue.localized())
        }
        if (phoneNumber.trim().isEmpty) {
            return .failure(AlertMessages.emptyPhone.rawValue.localized())
        }
        if phoneTest.evaluate(with: phoneNumber.trim()) == false {
            return .failure(AlertMessages.inValidPhone.rawValue.localized())
        }
        if (emailID.trim().isEmpty) {
            return .failure(AlertMessages.emptyEmail.rawValue.localized())
        }
        if emailTest.evaluate(with: emailID.trim()) == false{
            return .failure(AlertMessages.inValidEmail.rawValue.localized())
        }
        return .success
    }
}

func alertMessase(withTitle : String? = KString.strAppHeader, message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->())) {
    
    let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
        cancelAction?()
    }
    let okButton = UIAlertAction(title: "Ok", style: .default) { (ok) in
        okAction()
    }
    if cancelAction != nil {
        alertMessageController.addAction(cancelButton)
    }
    alertMessageController.addAction(okButton)
    let appWindow = UIApplication.shared.delegate?.window??.rootViewController
    appWindow?.present(alertMessageController, animated: true, completion: nil)
}
