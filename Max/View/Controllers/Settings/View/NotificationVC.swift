//
//  NotificationVC.swift
//  Max
//
//  Created by Rahul on 04/01/22.
//

import UIKit

class NotificationVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var tblNotification: UITableView!
    var arrItem: [NotificationItem] = [NotificationItem]()

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI() {
        arrItem.append(NotificationItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Reminder to start practice", color: UIColor.white))
        arrItem.append(NotificationItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Reminder to stop practice", color: UIColor.white))
        arrItem.append(NotificationItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Patient limit for slot achieved", color: UIColor.white))
        arrItem.append(NotificationItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "New appointment booked", color: UIColor.white))
        arrItem.append(NotificationItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "New IPD admissions", color: UIColor.white))
    }
    
    //MARK:-Action
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblNotification.dequeueReusableCell(withIdentifier: TblNotificationCell.identifire, for: indexPath) as? TblNotificationCell else {
            return UITableViewCell()
        }
        let objItem = arrItem[indexPath.row]
        cell.lblNotification.text = objItem.name
        cell.imgSelectionMark.backgroundColor = objItem.color
        cell.imgSelectionMark.image = objItem.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let objItem = arrItem[index]
        if objItem.isSelected == false {
            arrItem[index].isSelected = true
            arrItem[index].color = UIColor.AppThemeSkyBlueColor()
            arrItem[index].image = #imageLiteral(resourceName: "AWhiteCheckMark")
        } else {
            arrItem[index].isSelected = false
            arrItem[index].color = UIColor.white
            arrItem[index].image = #imageLiteral(resourceName: "AGrayRectangle")
        }
        tblNotification.reloadData()
    }
}

struct NotificationItem {
    var isSelected: Bool
    var image: UIImage
    let name: String
    var color: UIColor
}
