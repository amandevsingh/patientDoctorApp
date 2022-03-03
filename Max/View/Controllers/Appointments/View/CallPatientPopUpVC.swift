//
//  CallPatientPopUpVC.swift
//  Max
//
//  Created by Rahul on 30/12/21.
//

import UIKit

class CallPatientPopUpVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var vwBlur: UIView!


    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBlur.addSubview(blurredView)
    }
    
    //MARK:-Action
    @IBAction func btnCallFromPersonalNumberTapped(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + "8376929308") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func btnCallFromCentralLineNumberTapped(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + "8376929308") else { return }
        UIApplication.shared.open(number)
    }
}
