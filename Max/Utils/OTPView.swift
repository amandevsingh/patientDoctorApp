//
//  OTPView.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
    
    override func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}

class OTPView: UIStackView {
    
    var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }
    
    //To setup stackview
    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    //To setup text fields
    private func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
            
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.backgroundColor = .white
//            field.layer.opacity = 0.5
//            field.textAlignment = .center
//            field.layer.shadowColor = UIColor.black.cgColor
//            field.layer.shadowOpacity = 0.1
            
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}

extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }
}
