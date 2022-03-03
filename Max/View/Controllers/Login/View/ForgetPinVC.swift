//
//  ForgetPinVC.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class ForgetPinVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblEnterOTP: UILabel!
    @IBOutlet weak var txtOTP: PinCodeTextField!
    @IBOutlet weak var lblErrorMsg: UILabel!
    @IBOutlet weak var vwResend: UIView!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        txtOTP.keyboardType = .numberPad
    }
    
    func loadUI() {
        btnResend.isHidden = true
        lblErrorMsg.isHidden = true
        vwResend.isHidden = true
        txtPhone.delegate = self
    }
    
    //MARK:-Action
    @IBAction func btnCountryCodeTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnResendOTPTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnGetOTPTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Get OTP" {
            if txtPhone.text?.count == 10 {
                vwResend.isHidden = false
                sender.setTitle("Submit", for: .normal)
            } else {
                Utility.alertMessase(message: "Please enter number", okAction: {}, controller: self)
            }
        } else {
            if txtOTP.text?.count == 6 {
                let setUpPinVC: SetUpPinVC = SetUpPinVC.instantiate(appStoryboard: .login)
                setUpPinVC.isFromForgot = true
                self.navigationController?.pushViewController(setUpPinVC, animated: true)
            } else {
                Utility.alertMessase(message: "Please enter number OTP", okAction: {}, controller: self)
            }
        }
    }
}

extension ForgetPinVC: UITextFieldDelegate {
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
