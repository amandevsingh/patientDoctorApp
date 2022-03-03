//
//  VedioChatCancelPopUpVC.swift
//  Biocon
//
//  Created by Satyam Kumar on 01/03/22.
//  Copyright © 2022 Twilio. All rights reserved.
//

import UIKit

class VedioChatCancelPopUpVC: MaxBaseVC {
    @IBOutlet weak var viewShowHide: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
//MARK: - Life Cycle
extension VedioChatCancelPopUpVC{
    
}
 
//MARK: - IBAction
extension VedioChatCancelPopUpVC{
    @IBAction func noBtn(_ sender:UIButton){
        
    }
    @IBAction func yesBtn(_ sender:UIButton){
        let callPatientPopUpVC: VideoChatFeedbackVC = VideoChatFeedbackVC.instantiate(appStoryboard: .myPatient)
        self.present(callPatientPopUpVC, animated: true, completion: nil)
    }
}
