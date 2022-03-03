//
//  PrescriptionDetailView.swift
//  Max
//
//  Created by Ankit on 04/02/22.
//

import UIKit

enum UploadPrescriptionPopupViewAction {
case upload
case add
case close
}

protocol UploadPrescriptionPopupViewDelegate: AnyObject{
    func pickerViewPopupViewExtension(sender: UploadPrescriptionPopupView, didSelectOption : UploadPrescriptionPopupViewAction,data: [Data]?,files: [AttachmentInfo]?)
}

class UploadPrescriptionPopupView: UIViewController {

    var titleString:String = ""
    var dataArray: [Data] = [Data]()
    var files: [AttachmentInfo]?
    weak var delegate: UploadPrescriptionPopupViewDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addPrescriptionButton: UIButton!
    @IBOutlet weak var uploadPrescriptionButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var prescriptionCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        prescriptionCountLabel.text = "\(dataArray.count) Prescription"
        addPrescriptionButton.addTarget(self, action: #selector(addPrescriptionButtonAction), for: .touchUpInside)
        uploadPrescriptionButton.addTarget(self, action: #selector(uploadPrescriptionButtonAction), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }

    static func instantiate() -> UploadPrescriptionPopupView? {
        return UploadPrescriptionPopupView(nibName: nil, bundle: nil)
    }

    @objc func addPrescriptionButtonAction(){
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .add,data: dataArray,files: files)
    }

    @objc func uploadPrescriptionButtonAction(){
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .upload,data: dataArray,files: files)
    }

    @objc func closeButtonAction(){
        delegate?.pickerViewPopupViewExtension(sender: self, didSelectOption: .close,data: dataArray,files: files)
    }
}
