//
//  SettingsVC.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class SettingsVC: UIViewController {

    //MARK:-IBOutlet
    @IBOutlet weak var tblSetting: UITableView!
    let settingViewModel = SettingViewModel()

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     settingViewModel.loadUI()
    }

}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.getSettingsItemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblSetting.dequeueReusableCell(withIdentifier: TblSettingCell.identifire, for: indexPath) as? TblSettingCell else {
            return UITableViewCell()
        }
        cell.setUp(settingViewModel: settingViewModel,index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let profileVC: ProfileVC = ProfileVC.instantiate(appStoryboard: .setting)
            self.navigationController?.pushViewController(profileVC, animated: true)
        case 1:
            let notificationVC: NotificationVC = NotificationVC.instantiate(appStoryboard: .setting)
            self.navigationController?.pushViewController(notificationVC, animated: true)
        case 2:
            let permissionsVC: PermissionsVC = PermissionsVC.instantiate(appStoryboard: .setting)
            self.navigationController?.pushViewController(permissionsVC, animated: true)
        case 3:
            let contactSupportVC: ContactSupportVC = ContactSupportVC.instantiate(appStoryboard: .support)
            self.navigationController?.pushViewController(contactSupportVC, animated: true)
        case 4:
            let vc: VideoConsultationSupportServicesVC = VideoConsultationSupportServicesVC.instantiate(appStoryboard: .setting)
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            logout()
        default:
            break
        }
    }
}

extension SettingsVC {

    fileprivate func logout(){
       let alert = UIAlertController(title: "LOGOUT", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: {_ in
           self.settingViewModel.removeAllDataFromUserDefaults()
       }))
       alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
       self.present(alert, animated: true, completion: nil)
    }
}


