

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBDesignable
    class DesignableUITextField: UITextField {
        
        // Provides left padding for images
        override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leadingPadding
            return textRect
        }
        
        // Provides right padding for images
        override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.rightViewRect(forBounds: bounds)
            textRect.origin.x -= leadingPadding
            return textRect
        }
        
        @IBInspectable
        var leadingImage: UIImage? {
            didSet {
                updateView()
            }
        }
        
        @IBInspectable
        var leadingPadding: CGFloat = 0
        
        @IBInspectable
        var color: UIColor = UIColor.lightGray {
            didSet {
                updateView()
            }
        }
        
        @IBInspectable
        var rtl: Bool = false {
            didSet {
                updateView()
            }
        }
        
        func updateView() {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
            
            if let image = leadingImage {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                imageView.image = image
                // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
                imageView.tintColor = color
                
                if rtl {
                    rightViewMode = UITextField.ViewMode.always
                    rightView = imageView
                } else {
                    leftViewMode = UITextField.ViewMode.always
                    leftView = imageView
                }
            }
            
            // Placeholder text color
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        }
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
