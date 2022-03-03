//
//  RaiseAnIssueViewController.swift
//  Max
//
//  Created by aravind  yadav on 04/02/22.
//

import UIKit

class RaiseAnIssueViewController: MaxBaseVC {

    var notes: [Notes]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnRaise(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }

}
