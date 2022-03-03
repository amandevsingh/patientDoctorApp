//
//  PrescriptionUploadedView.swift
//  Max
//
//  Created by Ankit on 05/02/22.
//

import UIKit

protocol PrescriptionUploadedViewDelegate: AnyObject {
func uploadFinished()
}

class PrescriptionUploadedView: UIViewController {

    var titleString:String = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!

    weak var delegate:PrescriptionUploadedViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.delegate?.uploadFinished()
        }
    }

    static func instantiate() -> PrescriptionUploadedView? {
        return PrescriptionUploadedView(nibName: nil, bundle: nil)
    }

}
