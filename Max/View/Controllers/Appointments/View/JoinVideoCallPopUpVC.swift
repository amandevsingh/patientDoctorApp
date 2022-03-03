//
//  JoinVideoCallPopUpVC.swift
//  Max
//
//  Created by Rahul on 29/12/21.
//

import UIKit

class JoinVideoCallPopUpVC: MaxBaseVC {
    
    //MARK:-IBOutlet
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var imgUser: UIImageView!


    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBlur.addSubview(blurredView)
    }
    
    //MARK:-Action
    @IBAction func btnCheckMicTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnCheckVideoTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnCheckSwitchCamTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnJoinVideoCallTapped(_ sender: UIButton) {
    }
}
