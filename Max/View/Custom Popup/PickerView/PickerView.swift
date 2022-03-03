//
//  PickerView.swift
//  Max
//
//  Created by Ankit on 04/02/22.
//

import UIKit

enum PickerViewAction: Int {
case camera = 1
case gallery = 2
case close = 3
}

protocol PickerViewDelegate: AnyObject
{
    func pickerViewPopupViewExtension(sender: PickerView, didSelectOption : PickerViewAction)
}

class PickerView: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    weak var delegate: PickerViewDelegate?
    var titleString:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        cameraButton.addTarget(self, action: #selector(cameraButtonAction), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonAction), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    static func instantiate() -> PickerView? {
        return PickerView(nibName: nil, bundle: nil)
    }


    @objc func closeButtonAction() {
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .close)
    }

    @objc func cameraButtonAction() {
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .camera)
    }

    @objc func galleryButtonAction() {
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .gallery)
    }

}
