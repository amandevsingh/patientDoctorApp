//
//  LogInVC.swift
//  Max
//
//  Created by Rahul on 11/12/21.
//

import UIKit

class LogInVC: MaxBaseVC {
    
    //MARK:-IBOutlet
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var vwPhoneNumber: UIView!
    @IBOutlet weak var lblErrorMsg: UILabel!//Error: Account does not exist
    
    var viewModel = LoginViewModel()
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhone.text = "8888888888"
        viewModel.login.mobileNumber = "8888888888"
        txtPhone.delegate = self
    }
    
    //MARK:-Action
    @IBAction func btnCountryCodeTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Country", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "CountryPickerViewController") as! CountryPickerViewController
//        controller.completion = { dict in
//        self.btnCountryCode.setTitle(dict["dial_code"] ?? "", for: .normal)
//        self.viewModel.inputCountryCode(countryCode: dict["dial_code"] ?? "")
//        }
//        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnLoginByPinTapped(_ sender: UIButton) {
        let loginByPinVC: LoginPinVC = LoginPinVC.instantiate(appStoryboard: .login)
        self.navigationController?.pushViewController(loginByPinVC, animated: true)
    }
    
    @IBAction func btnGetOtpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        //print(viewModel.login.countryCode)
        // print(viewModel.login.mobileNumber)
        if isValidMobileNumber() {
        viewModel.loginAttemptOTP("8888888888") {
        print("=====Successfully done login========")
            let otpVerificationVC: OTPVerificationVC = OTPVerificationVC.instantiate(appStoryboard: .login)
            otpVerificationVC.login = self.viewModel.login
            self.navigationController?.pushViewController(otpVerificationVC, animated: true)
         }
       }
    }

        func isValidMobileNumber() -> Bool{
            var isValid = false
            if (viewModel.login.mobileNumber?.isEmpty ?? false || viewModel.login.mobileNumber == "" || viewModel.login.mobileNumber == nil) {
           Utility.alertMessase(message: "Please enter the mobile number", okAction: {}, controller: self)
            }
//            else if !(viewModel.login.mobileNumber?.isValidMobileNumber ?? false) {
//            Utility.alertMessase(message: "Please enter a valid mobile number", okAction: {}, controller: self)
//            }
            
            else {
            isValid = true
            }
          return isValid

        }

    @IBAction func btnForgetPinTapped(_ sender: UIButton) {
        if viewModel.login.mobileNumber?.count == 10 {
            let forgetPinVC: ForgetPinVC = ForgetPinVC.instantiate(appStoryboard: .login)
            self.navigationController?.pushViewController(forgetPinVC, animated: true)
        } else {
            Utility.alertMessase(message: "Please enter valid number", okAction: {}, controller: self)
        }
    }
}

extension LogInVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
     viewModel.inputMobileNumber(mobileNumber: textField.text ?? "")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == self.txtPhone  && string.count > 0{
            let numberOnly = NSCharacterSet.decimalDigits
            let strValid = numberOnly.contains(UnicodeScalar.init(string)!)
            return strValid && textString.count <= 10
        }
        return true
    }
}
