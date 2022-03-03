//
//  PatientDetailsVC.swift
//  Max
//
//  Created by Satyam Kumar on 27/02/22.
//

import UIKit

class PatientDetailsVC: UIViewController {


    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientMobileNoLabel: UILabel!
    @IBOutlet weak var patientMaxIDLabel: UILabel!
    @IBOutlet weak var visitTableView: UITableView!
    @IBOutlet weak var maxHeathCareRecord:UITableView!
    @IBOutlet weak var visitTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var maxHeathCareRecordHeight: NSLayoutConstraint!
    var visitDetails = [["date":"15 Sep’21  |  10:50 AM","status":"Status: Upcoming"],["date":"1 Sep’21  |  10:50 AM","status":"Status: Checked-In"],["date":"28 Aug’21  |  10:50 AM","status":"Status: Completed"],["date":"2 Aug’21  |  10:50 AM","status":"Status: Cancelled"],["date":"2 Aug’21  |  10:50 AM","status":"Status: No Show"]]
}
//MARK:-Life Cycle
extension PatientDetailsVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        visitTableView.register(UINib(nibName: "VisitsTableViewCell", bundle: nil), forCellReuseIdentifier: "VisitsTableViewCell")
        maxHeathCareRecord.register(UINib(nibName: "MaxHealthCareRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "MaxHealthCareRecordTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.visitTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.maxHeathCareRecord.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.visitTableView.removeObserver(self, forKeyPath: "contentSize")
        self.maxHeathCareRecord.removeObserver(self, forKeyPath: "contentSize")
       
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if let obj = object as? UIScrollView {
            if obj == self.visitTableView && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.visitTableViewHeight.constant = newsize.height
                }
            }else if obj == self.maxHeathCareRecord && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.maxHeathCareRecordHeight.constant = newsize.height
                }
            }
        }
    }
}
//MARK:-Action
extension PatientDetailsVC{
    @IBAction func backBtn(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
    
}
extension PatientDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == maxHeathCareRecord{
            return 1
        }
        return visitDetails.count
        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == maxHeathCareRecord{
            let cell = maxHeathCareRecord.dequeueReusableCell(withIdentifier: "MaxHealthCareRecordTableViewCell") as! MaxHealthCareRecordTableViewCell
           
            return cell
        }
       
        let cell = visitTableView.dequeueReusableCell(withIdentifier: "VisitsTableViewCell") as! VisitsTableViewCell
        let visit = visitDetails[indexPath.row]
            cell.dateLabel!.text! = visit["date"]!
            cell.statusLabel!.text! = visit["status"]!
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let callPatientPopUpVC: VedioChatCancelPopUpVC = VedioChatCancelPopUpVC.instantiate(appStoryboard: .myPatient)
        callPatientPopUpVC.modalTransitionStyle = .crossDissolve
        callPatientPopUpVC.modalPresentationStyle = .overCurrentContext
        self.present(callPatientPopUpVC, animated: true, completion: nil)
    }
    
    
}
