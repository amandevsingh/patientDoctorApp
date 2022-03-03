//
//  Alert.swift
//  Max
//
//  Created by Rahul on 18/12/21.
//

import UIKit

class Alert: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var alertTypeImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var consHeightView: NSLayoutConstraint!//200
    
    var type: AlertType = .success
    var strDes: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: Swift.type(of: self))
        bundle.loadNibNamed("Alert", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setUIWithType()
    }
    
    private func setUIWithType() {
        lblTitle.text = strDes
        switch type {
        case .success:
            alertTypeImage.image = #imageLiteral(resourceName: "AlertSuccess")
        case .error:
            alertTypeImage.image = #imageLiteral(resourceName: "AlertError")
        case .loading:
            alertTypeImage.image = #imageLiteral(resourceName: "AlertLoading")
        }
    }
}
