//
//  SelectDoctorsVC.swift
//  Max
//
//  Created by Satyam Kumar on 28/02/22.
//

import UIKit
import SwiftUI

class SelectDoctorsVC: MaxBaseVC {
    @IBOutlet weak var heightOfViewshowDate: NSLayoutConstraint!
    
    @IBOutlet weak var viewShowHide: UIView!
    //MARK:-IBOutlet
    @IBOutlet weak var tblSelectDoctor: UITableView!
   
    

}
//MARK:- Life Cycle
extension SelectDoctorsVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSelectDoctor.register(UINib(nibName: "SelectDoctorsTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectDoctorsTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tblSelectDoctor.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        self.tblSelectDoctor.removeObserver(self, forKeyPath: "contentSize")
     
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if let obj = object as? UIScrollView {
            if obj == self.tblSelectDoctor && keyPath == "contentSize" {
                if let newvalue = change?[.newKey]{
                    let newsize  = newvalue as! CGSize
                    self.heightOfViewshowDate.constant = newsize.height
                }
            }
        }
    }
    
   
}
//MARK:- Action
extension SelectDoctorsVC{
   
    @IBAction func saveBtn(_ sender:UIButton){
        
    }
}//MARK: - TableMethod
extension SelectDoctorsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSelectDoctor.dequeueReusableCell(withIdentifier: "SelectDoctorsTableViewCell") as! SelectDoctorsTableViewCell


    return cell
    }
}

extension SelectDoctorsVC:UITableViewDelegate{
   
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             if let cell = tableView.cellForRow(at: indexPath)as? SelectDoctorsTableViewCell{
                 cell.radioBtn.setImage(UIImage(named: "radio_btn_on"), for: .normal)
                 cell.shadowView.layer.borderWidth = 1
                 cell.shadowView.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.7254901961, blue: 0.7058823529, alpha: 1)
                 
                        }
        }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)as? SelectDoctorsTableViewCell{
            cell.radioBtn.setImage(UIImage(named: "radio_btn_off"), for: .normal)
            cell.shadowView.layer.borderWidth = 1
            cell.shadowView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                     }
    }
    
}

