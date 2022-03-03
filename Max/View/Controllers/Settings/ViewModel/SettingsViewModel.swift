//
//  ViewModel.swift
//  Max
//
//  Created by Ankit on 21/01/22.
//

import Foundation
import UIKit
import Kingfisher

class SettingViewModel {

    private var settingsModelArray: [SettingsModel] = [SettingsModel]()

    func loadUI() {
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.3529411765), green: Float(0.7254901961), blue: Float(0.7058823529), alpha: Float(0.2)), name: "Profile", image: #imageLiteral(resourceName: "ASProfile")))
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.9215686275), green: Float(0.3450980392), blue: Float(0.3450980392), alpha: Float(0.2)), name: "Notification", image: #imageLiteral(resourceName: "ASNotification")))
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.9254901961), green: Float(0.7529411765), blue: Float(0.3058823529), alpha: Float(0.2)), name: "Permission", image: #imageLiteral(resourceName: "ASPermission")))
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.9215686275), green: Float(0.3450980392), blue: Float(0.3450980392), alpha: Float(0.2)), name: "Report Issue", image: #imageLiteral(resourceName: "ASReportIssue")))
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.9215686275), green: Float(0.3450980392), blue: Float(0.3450980392), alpha: Float(0.2)), name: "Video Consultation Support Services", image: #imageLiteral(resourceName: "ASReportIssue")))
        settingsModelArray.append(SettingsModel(color: #colorLiteral(red: Float(0.3529411765), green: Float(0.7254901961), blue: Float(0.7058823529), alpha: Float(0.2)), name: "Logout", image: #imageLiteral(resourceName: "ASLogout")))
    }

    var lastIndex: Int {
    return settingsModelArray.count - 1
    }

    var getSettingsItemCount : Int {
     return settingsModelArray.count
    }

    func getSettingItem(index: Int) -> SettingsModel {
      return settingsModelArray[index]
    }

    func removeAllDataFromUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.loadInitialController()
    }
    }

    


}
