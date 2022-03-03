//
//  SetUpPinVC.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class SetUpPinVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var txtEnterPin: PinCodeTextField!
    @IBOutlet weak var txtReEnterPin: PinCodeTextField!
    var verifyOtp: VerifyOtp?
    var isFromForgot: Bool = false
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEnterPin.keyboardType = .numberPad
        txtReEnterPin.keyboardType = .numberPad
    }
    
    //MARK:-Action
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if txtEnterPin.text?.count == 6 && txtReEnterPin.text?.count == 6 && txtEnterPin.text == txtReEnterPin.text{
            if isFromForgot {
                guard let loginPinVC = self.navigationController?.viewControllers.filter({$0.isKind(of: LoginPinVC.self)}).first else {return}
                self.navigationController?.popToViewController(loginPinVC, animated: true)
            } else {
                Utility.moveToDashboard((SceneDelegate.shared?.window!)!)
            }
        }else if txtEnterPin.text?.count != 6
        {
            Utility.alertMessase(message: "please Enter pin", okAction: {}, controller: self)
        }else if txtReEnterPin.text?.count != 6
        {
            Utility.alertMessase(message: "please ReEnter pin", okAction: {}, controller: self)
        } else if txtEnterPin.text != txtReEnterPin.text {
            Utility.alertMessase(message: "pin not match", okAction: {}, controller: self)
        }
    }
}
