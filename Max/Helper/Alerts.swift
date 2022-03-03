
//  Alerts.swift

//
//  Created by Sierra 4 on 14/07/17.
//  Copyright © 2017 com.example. All rights reserved.

import UIKit
import SwiftMessages

typealias AlertBlock = (_ success: AlertTag) -> ()

enum AlertTitle : String{
    case success = "Success"
    case oops = "Alert"
    case login = "Login Successfull"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case warning = "Warning"
}

enum Type{
    case success
    case warning
    case error
    case info
}

enum AlertTag {
    case done
    case yes
    case no
}

class Alerts: NSObject {

    static let shared = Alerts()

    //MARK: - Show Alert
    func show(alert title : AlertTitle , message : String , type : Type){

        var alertConfig = SwiftMessages.defaultConfig
        alertConfig.presentationStyle = .bottom
        alertConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        alertConfig.duration = .seconds(seconds: 2.0)

        let alertView = MessageView.viewFromNib(layout: .messageView)
        alertView.button?.isHidden = true
        alertView.configureDropShadow()
        alertView.titleLabel?.font = UIFont.proximaNovaRegular(of: 18)
        alertView.bodyLabel?.text = message
        alertView.bodyLabel?.font = UIFont.proximaNovaRegular(of: 16)
        alertView.configureContent(title: title.rawValue, body: message)

        switch type {
        case .error:
            alertView.configureTheme(.error)
        case .info:
            alertView.configureTheme(.info)
            alertView.backgroundView.backgroundColor = .black
        case .success:
            alertView.configureTheme(.success)
                alertView.backgroundView.backgroundColor = .green
        case .warning:
            alertView.configureTheme(.warning)
            alertView.backgroundView.backgroundColor = .black
            //alertView.backgroundView.backgroundColor = .themeRedColor()
        }

        alertView.titleLabel?.textColor = UIColor.white
        alertView.bodyLabel?.textColor = UIColor.white
        SwiftMessages.show(config: alertConfig, view: alertView)

    }
}

