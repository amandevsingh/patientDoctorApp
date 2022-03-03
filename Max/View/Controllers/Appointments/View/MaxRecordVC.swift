//
//  MaxRecordVC.swift
//  Max
//
//  Created by Aravind on 20/12/21.
//

import UIKit
class MaxRecordVC: MaxBaseVC {
    var iscomingFrom = ""
    @IBOutlet weak var heightOfViewshowDate: NSLayoutConstraint!
    
    @IBOutlet weak var viewShowHide: UIView!
    //MARK:-IBOutlet
    @IBOutlet weak var tblUploadedDocument: UITableView!
    

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !iscomingFrom.isEmpty{
            heightOfViewshowDate.constant = 180
            viewShowHide.isHidden = false
        }
    }
    
    
    //MARK:-Action
}
extension MaxRecordVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblUploadedDocument.dequeueReusableCell(withIdentifier: TblUploadedDocumentCell.identifire, for: indexPath) as? TblUploadedDocumentCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
