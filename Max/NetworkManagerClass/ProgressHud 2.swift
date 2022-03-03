//
//  ProgressHud.swift
//  BarberOnDemand
//
//  Created by Quytech_shivamiOS on 23/04/20.
//  Copyright © 2020 Quytech. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
//import NVActivityIndicatorView
//import PBRevealViewController

class JGProgress {
    
    static let instance = JGProgress(type: .dark)

    let hud: JGProgressHUD
    
    init(type: JGProgressHUDStyle) {
        self.hud = JGProgressHUD(style: type)
    }

    func showActivityLoader(_ text: String = "", view: UIView? = nil) {
        DispatchQueue.main.async {
            if let bg = view {
                self.hud.textLabel.text = text
                self.hud.show(in: bg)
            }
        }
    }
    
    func hideActivityLoader() {
        DispatchQueue.main.async {
            self.hud.dismiss(afterDelay: 2.0)
        }
    }
    
    func showActivity() {
//        DispatchQueue.main.async {
//            if let bg = UIApplication.getTopViewController()?.view {
//                self.hud.show(in: bg)
//            }
//        }
    }
    
    func hideActivity() {
        DispatchQueue.main.async {
            self.hud.dismiss()
        }
    }
}

//extension UIApplication {
//
//    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//
//        } else if let tab = base as? PBRevealViewController, let selected = tab.mainViewController {
//            return getTopViewController(base: selected)
//
//        } else if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//
//        }
//        return base
//    }
//}

/*

 class NVProgress: UIViewController, NVActivityIndicatorViewable {
     
     static let shared = NVProgress()
     
     /// Show Activity Loader
     static func showActivityLoader() {
         DispatchQueue.main.async {
             let object = NVProgress.shared
             object.startAnimating(nil, message: nil, messageFont: nil, type: .ballClipRotate, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
         }
     }
     /// Hide Activity Loader
     static func hideActivityLoader() {
         DispatchQueue.main.async {
             let object = NVProgress.shared
             object.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
         }
     }
 }

 
 */

