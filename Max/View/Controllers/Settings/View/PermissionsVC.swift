//
//  PermissionsVC.swift
//  Max
//
//  Created by Rahul on 04/01/22.
//

import UIKit

class PermissionsVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var tblPermission: UITableView!
    @IBOutlet weak var consHeightTbl: NSLayoutConstraint!//226,50
    var arrItem: [PermissionItem] = [PermissionItem]()

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI() {
        arrItem.append(PermissionItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), title: "Auto-book appointment on marking follow up", subtitle: nil, color: UIColor.white, startChat: nil, endChat: nil, videoLimit: nil))
        arrItem.append(PermissionItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), title: "Enable patient chat for video consultation", subtitle: nil, color: UIColor.white, startChat: "0 Hours", endChat: "48 Hours", videoLimit: "5"))
        arrItem.append(PermissionItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), title: "Send message to patient in case of delay", subtitle: nil, color: UIColor.white, startChat: nil, endChat: nil, videoLimit: nil))
        arrItem.append(PermissionItem(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), title: "Enable Video Consultation Back Office support", subtitle: "Document Quality Check, Patient Assistance, Case Summary", color: UIColor.white, startChat: nil, endChat: nil, videoLimit: nil))
    }
    
    //MARK:-Action
    @IBAction func btnSaveTapped(_ sender: UIButton) {
    }
}

extension PermissionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            guard let cell = tblPermission.dequeueReusableCell(withIdentifier: PermissionsTblCell.identifire, for: indexPath) as? PermissionsTblCell else {
                return UITableViewCell()
            }
            let indexCell = indexPath.row
            let objItem = arrItem[indexCell]
            cell.configure(objItem)
            cell.startChat = { item,index in
                self.arrItem[indexCell].startChat = item
            }
            cell.endChat = { item,index in
                self.arrItem[indexCell].endChat = item
            }
            cell.videoLimit = { item,index in
                self.arrItem[indexCell].videoLimit = item
            }
            return cell
        } else {
            guard let cell = tblPermission.dequeueReusableCell(withIdentifier: TblNotificationCell.identifire, for: indexPath) as? TblNotificationCell else {
                return UITableViewCell()
            }
            let objItem = arrItem[indexPath.row]
            cell.lblNotification.text = objItem.title
            cell.imgSelectionMark.backgroundColor = objItem.color
            cell.lblInfo.text = /objItem.subtitle
            cell.imgSelectionMark.image = objItem.image
            return cell
        }
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
        tblPermission.reloadData()
    }
}

struct PermissionItem {
    var isSelected: Bool
    var image: UIImage
    let title: String
    let subtitle: String?
    var color: UIColor
    var startChat: String?
    var endChat: String?
    var videoLimit: String?
}
