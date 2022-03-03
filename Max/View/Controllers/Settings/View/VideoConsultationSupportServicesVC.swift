//
//  VideoConsultationSupportServicesVC.swift
//  Max
//
//  Created by Rahul on 16/01/22.
//

import UIKit

class VideoConsultationSupportServicesVC: MaxBaseVC {
    
    //MARK:-IBOutlet
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblSupportService: UITableView!
    
    let arrSection: [String] = ["1. Who will Prepare Case summary for patients?","2. Do you want to avail following Support Services?"]
    var arrItem: [VideoSupport] = []
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "My Team", subtitle: "", color: .white))
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Video Consultation Support Team", subtitle: "", color: .white))
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "None", subtitle: "", color: .white))
        
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Document Quality Check", subtitle: "All the uploaded documents are checked and arranged in order (if >4 hrs left for consultation)", color: .white))
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Manual Reminder Calling", subtitle: "If enabled, instead of IVR call, manual call is made to patients 5 mins before the video consultation", color: .white))
        arrItem.append(VideoSupport(isSelected: false, image: #imageLiteral(resourceName: "AGrayRectangle"), name: "Patient mobile issues handling", subtitle: "Patients’ mobile issues (app not downloaded, app permissions, etc) will be resolved over call", color: .white))
    }
    
    //MARK:-Action
    @IBAction func btnSaveTapped(_ sender: UIButton) {
    }
}

extension VideoConsultationSupportServicesVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblSupportService.dequeueReusableCell(withIdentifier: TblNotificationCell.identifire, for: indexPath) as? TblNotificationCell else {
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
        tblSupportService.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrSection[section]
    }
}

struct VideoSupport {
    var isSelected: Bool
    var image: UIImage
    let name: String
    let subtitle: String?
    var color: UIColor
}
