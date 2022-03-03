//
//  CalendarCollectionViewCell.swift
//  Max
//
//  Created by Ankit on 20/01/22.
//

import FSCalendar
import UIKit

import FSCalendar
import UIKit

enum SelectionType {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarCollectionViewCell: FSCalendarCell {

    weak var circleImageView: UIImageView?
    weak var selectionLayer: CAShapeLayer?
    weak var roundedLayer: CAShapeLayer?
    var isSelectedDate: Bool = true {
        didSet {
         setNeedsLayout()
       //layoutSubviews()
        }
    }

    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.lightGray.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel?.layer)
        self.selectionLayer = selectionLayer

        let roundedLayer = CAShapeLayer()
        roundedLayer.fillColor = UIColor.blue.cgColor
        roundedLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedLayer, below: self.titleLabel?.layer)
        self.roundedLayer = roundedLayer

        self.shapeLayer.isHidden = true
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let selectionLayer = selectionLayer, let roundedLayer = roundedLayer else { return }
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectionLayer?.frame = self.contentView.bounds
        self.roundedLayer?.frame = self.contentView.bounds

        switch selectionType {
        case .middle:
            let shadowLayer = CAShapeLayer()
//            shadowLayer.fillColor = !isSelectedDate ? UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5).cgColor : UIColor(hex: "4DA9D0").cgColor
            shadowLayer.fillColor = UIColor(hex: "4DA9D0").cgColor
                //UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5).cgColor :
            shadowLayer.lineWidth = 0
            let shadowSize = CGSize(width: self.frame.size.width - 10, height: self.frame.size.height-2)
               // CGRect shawdowBounds = CGRectMake(0, 0, shadowSize.width, shadowSize.height);
           // let shadowBounds = CGRect(x: 0, y: 0, width: shadowSize.width-1, height: shadowSize.height-1)
                let shadowBounds = CGRect(x: 0, y: 0, width: shadowSize.width - 1, height: shadowSize.height - 1)
                let bezierPath = UIBezierPath(roundedRect: shadowBounds, cornerRadius: 20)
                //UIBezierPath(roundedRect: shadowBounds, byRoundingCorners: UIRectCorner(rawValue: 2), cornerRadii: CGSize(width: 10, height: 10))
                shadowLayer.path = bezierPath.cgPath
                //UIBezierPath.init(ovalIn: shadowBounds).cgPath
            shadowLayer.bounds = shadowBounds
            shadowLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            self.contentView.layer.insertSublayer(shadowLayer, at: 0)
                /*
                 shadowLayer.path = [UIBezierPath bezierPathWithOvalInRect:shawdowBounds].CGPath;
                 shadowLayer.bounds = shawdowBounds;
                 shadowLayer.position = CGPointMake(CGRectGetMidX(textField.bounds), CGRectGetMaxY(textField.bounds));
                 [containerView.layer insertSublayer:shadowLayer atIndex0];
                 */

//            self.selectionLayer?.isHidden = false
//            self.selectionLayer?.path = UIBezierPath(rect: selectionLayer.bounds).cgPath
//            self.roundedLayer?.isHidden = true

        case .leftBorder:
            let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: selectionLayer.frame.width / 4, dy: 0.0)
            self.selectionLayer?.isHidden = false
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

            let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
            let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
            self.roundedLayer?.isHidden = false
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .rightBorder:
            let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: -selectionLayer.frame.width / 4, dy: 0.0)
            self.selectionLayer?.isHidden = false
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

            let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
            let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
            self.roundedLayer?.isHidden = false
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

        case .single:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = false
            let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
            self.roundedLayer?.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath

        case .none:
           // self.selectionLayer?.isHidden = true
            //self.roundedLayer?.isHidden = true
                let shadowLayer = CAShapeLayer()
    //            shadowLayer.fillColor = !isSelectedDate ? UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5).cgColor : UIColor(hex: "4DA9D0").cgColor
                shadowLayer.fillColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5).cgColor
                    //UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5).cgColor :
                shadowLayer.lineWidth = 0
                let shadowSize = CGSize(width: self.frame.size.width - 10, height: self.frame.size.height-2)
                   // CGRect shawdowBounds = CGRectMake(0, 0, shadowSize.width, shadowSize.height);
               // let shadowBounds = CGRect(x: 0, y: 0, width: shadowSize.width-1, height: shadowSize.height-1)
                    let shadowBounds = CGRect(x: 0, y: 0, width: shadowSize.width - 1, height: shadowSize.height - 1)
                    let bezierPath = UIBezierPath(roundedRect: shadowBounds, cornerRadius: 20)
                    //UIBezierPath(roundedRect: shadowBounds, byRoundingCorners: UIRectCorner(rawValue: 2), cornerRadii: CGSize(width: 10, height: 10))
                    shadowLayer.path = bezierPath.cgPath
                    //UIBezierPath.init(ovalIn: shadowBounds).cgPath
                shadowLayer.bounds = shadowBounds
                shadowLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
                self.contentView.layer.insertSublayer(shadowLayer, at: 0)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()
        // Override the build-in appearance configuration
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
        }
    }
}
