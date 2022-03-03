//
//  Utility.swift
//  Max
//
//  Created by Rahul on 13/12/21.
//

import UIKit

class Utility: NSObject {

    class func alertMessase(withTitle : String? = KString.strAppHeader, message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->()), controller : UIViewController) {
        
        let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            cancelAction?()
        }
        let okButton = UIAlertAction(title: "Ok", style: .default) { (ok) in
            okAction()
        }
        if cancelAction != nil {
            alertMessageController.addAction(cancelButton)
        }
        alertMessageController.addAction(okButton)
        controller.present(alertMessageController, animated: true, completion: nil)
    }
    
    class func storyboardLogin() -> UIStoryboard {
        return UIStoryboard(name: AppStoryboard.login.rawValue, bundle: Bundle.main)
    }
    
    class func storyboardDashboard() -> UIStoryboard {
        return UIStoryboard(name: AppStoryboard.dashboard.rawValue, bundle: Bundle.main)
    }

    class func moveToDashboard(_ window: UIWindow) {
        let objBBNavController = storyboardDashboard().instantiateViewController(withIdentifier: "MaxNavController") as! MaxNavController
        window.rootViewController = objBBNavController
    }
    
    class func moveToLogin(_ window: UIWindow) {
        let objBBNavController = storyboardLogin().instantiateViewController(withIdentifier: "MaxNavController") as! MaxNavController
        window.rootViewController = objBBNavController
    }
    
    class func presentViewController(_ controller: UIViewController) {
        
    }
    
    class func pushViewController(_ controller: UIViewController) {
        
    }
    
}
