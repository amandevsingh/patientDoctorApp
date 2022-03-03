//
//  OTPVerificationVC.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class OTPVerificationVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var txtOTP: PinCodeTextField!
    @IBOutlet weak var vwResend: UIView!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    var viewModel = OTPVerificationViewModel()
    var login: Login?
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI() {
        btnResend.isHidden = true;
        txtOTP.keyboardType = .numberPad
    }
    
    //MARK:-Action
    @IBAction func btnChangeNumberTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResendOTPTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if txtOTP.text?.count == 6 {
            viewModel.verifyOTP("123456") {
            print("=====Successfully verify otp========")
                
        let setUpPinVC: SetUpPinVC = SetUpPinVC.instantiate(appStoryboard: .login)
                setUpPinVC.verifyOtp = self.viewModel.verifyOtp
                self.navigationController?.pushViewController(setUpPinVC, animated: true)
             }
            

        } else {
            Utility.alertMessase(message: "Enter OTP", okAction: {}, controller: self)
        }
    }
}
