//
//  MyPatientsVC.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class MyPatientsVC: UIViewController {

    //MARK:-IBOutlet
    @IBOutlet weak var patientTableView: UITableView!
    @IBOutlet weak var searchPatinetNameByPhone:UITextField!
    @IBOutlet weak var patientTableViewHeight: NSLayoutConstraint!
    var name = ["Sanchit Singhal","Shubham Sharma","Neeraj Sharma","Abhishek Sharma"]
}
//MARK:-Life Cycle
extension MyPatientsVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        patientTableView.register(UINib(nibName: "PatientsFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientsFoundTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.patientTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        self.patientTableView.removeObserver(self, forKeyPath: "contentSize")
     
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if let obj = object as? UIScrollView {
            if obj == self.patientTableView && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.patientTableViewHeight.constant = newsize.height
                }
            }
        }
    }
}
//MARK:-Action
extension MyPatientsVC{
    @IBAction func lastSevenDayAction(_ sender:UIButton){
        
    }
    @IBAction func searchBtn(_ sender:UIButton){
        
    }
    
}
extension MyPatientsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = patientTableView.dequeueReusableCell(withIdentifier: "PatientsFoundTableViewCell") as! PatientsFoundTableViewCell
        if indexPath.row == 0
        {
            cell.messageImage.isHidden = false
            cell.messageCount.isHidden = false
        }
        cell.patientName!.text! = name[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller:PatientDetailsVC = myPatientsStoryboard.instantiateViewController(withIdentifier: "PatientDetailsVC") as! PatientDetailsVC
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
