//
//  NoShowPatientPopUpVC.swift
//  Max
//
//  Created by Rahul on 30/12/21.
//

import UIKit

class NoShowPatientPopUpVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblActionMessage: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!

    let noShowViewModel = NoShowViewModel()
    var completion: ((_ toggleDone: Bool) -> Void)?
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       self.vwBlur.addSubview(blurredView)
    }
    
    //MARK:-Action
    @IBAction func btnYesTapped(_ sender: UIButton) {
        if btnYes.titleLabel?.text == "Okay" {

//            guard let opdPatientsVC = self.navigationController?.viewControllers.filter({$0.isKind(of: OPDPatientsVC.self)}).first else {return}
//            self.navigationController?.popToViewController(opdPatientsVC, animated: true)
            self.dismiss(animated: true) {
            self.completion?(true)
            }
        } else {
            noShowViewModel.toggleAppointmentStatus {
//
            }
            btnNo.isHidden = true
            lblActionMessage.text = "Patient has been marked as No Show and patient will be informed by message"
            btnYes.setTitle("Okay", for: .normal)
            btnYes.setTitleColor(UIColor.AppThemeGreenColor(), for: .normal)
            btnYes.backgroundColor = .white
            btnYes.borderWidth = 1
            btnYes.borderColor = UIColor.AppThemeGreenColor()
        }
    }
}
