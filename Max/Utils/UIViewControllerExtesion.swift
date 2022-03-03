//
//  UIViewControllerExtesion.swift
//  Max
//
//  Created by Rahul on 13/12/21.
//

import UIKit

extension UIViewController {
    
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    static var identifire: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

//MARK:-Table Cell
extension UITableViewCell {
    static var identifire: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
}

//MARK:-Collection Cell
extension UICollectionViewCell {
    static var identifire: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
}
