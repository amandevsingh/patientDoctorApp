//
//  CustomPopupView.swift
//  BottomPopup
//
//  Created by Apple on 03/09/21.
//

import UIKit

enum CustomPopupAction: Int {
case close = 1
case write = 2
case upload = 3
}

protocol CustomPopupViewDelegate: AnyObject
{
    func customPopupViewExtension(sender: CustomPopupView, didSelectOption : CustomPopupAction)
}

class CustomPopupView: UIViewController {

    var titleString: String?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton : UIButton!
    @IBOutlet weak var btnWritePriscription:UIButton!
    @IBOutlet weak var btnUploadPriscription:UIButton!
    
    weak var delegate: CustomPopupViewDelegate?
    static func instantiate() -> CustomPopupView? {
        return CustomPopupView(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString ?? ""
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        btnWritePriscription.addTarget(self, action: #selector(writeButtonAction), for: .touchUpInside)
        btnUploadPriscription.addTarget(self, action: #selector(uploadButtonAction), for: .touchUpInside)
    }

    @objc func doneButtonAction() {
        delegate?.customPopupViewExtension(sender: self, didSelectOption: .close)
   }
    
     @objc func writeButtonAction() {
         delegate?.customPopupViewExtension(sender: self, didSelectOption: .write)
    }

    @objc func uploadButtonAction() {
        delegate?.customPopupViewExtension(sender: self, didSelectOption: .upload)
   }
   
}
