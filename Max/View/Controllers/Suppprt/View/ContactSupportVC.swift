//
//  ContactSupportVC.swift
//  Max
//
//  Created by Rahul on 29/12/21.
//

import UIKit

class ContactSupportVC: MaxBaseVC {

    //MARK:-IBOutlet
    
    @IBOutlet weak var TblContactSupport: UITableView!
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:-Action

}

extension ContactSupportVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactSupportTableViewCell") as! ContactSupportTableViewCell
        let arrRow = ["Raise an Issue","Call Support Ececutive","How App Works"]
        cell.lbltype.text = arrRow[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = supportStoryboard.instantiateViewController(withIdentifier: "RaiseAnIssueViewController") as! RaiseAnIssueViewController
               self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = dashboardStoryboard.instantiateViewController(withIdentifier: "CallPatientPopUpVC") as! CallPatientPopUpVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
