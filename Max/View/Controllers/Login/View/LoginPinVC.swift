//
//  LoginPinVC.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class LoginPinVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var txtPin: PinCodeTextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPin.keyboardType = .numberPad
    }
    
    //MARK:-Action
    @IBAction func btnLoginByPinTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        if txtPin.text?.count == 6 {
            Utility.moveToDashboard((SceneDelegate.shared?.window!)!)
        } else {
            Utility.alertMessase(message: "Please enter 6 digits pin", okAction: {}, controller: self)
        }
    }
    
    @IBAction func btnForgetPinTapped(_ sender: UIButton) {
        let forgetPinVC: ForgetPinVC = ForgetPinVC.instantiate(appStoryboard: .login)
        self.navigationController?.pushViewController(forgetPinVC, animated: true)
    }
}
