//
//  BookSlotsAndleaveVC.swift
//  Max
//
//  Created by Rahul on 04/01/22.
//

import UIKit

class BookSlotsAndleaveVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var tblActiveRequests: UITableView!// 72 cell Height
    @IBOutlet weak var tblViewHistory: UITableView!// 72 cell Height
    @IBOutlet weak var btnViewHistory: UIButton!
    @IBOutlet weak var imgUpAndDown: UIImageView!
    @IBOutlet weak var consHeightActiveRequest: NSLayoutConstraint!
    @IBOutlet weak var consHeightViewHistory: NSLayoutConstraint!//45 min
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI() {
        consHeightViewHistory.constant = 144
        consHeightActiveRequest.constant = 144
        tblViewHistory.clipsToBounds = true
        tblViewHistory.layer.cornerRadius = 12
        tblViewHistory.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    //MARK:-Action
    @IBAction func btnNewRequestTapped(_ sender: UIButton) {
        let newRequestLeaveAndBookSlotVC: NewRequestLeaveAndBookSlotVC = NewRequestLeaveAndBookSlotVC.instantiate(appStoryboard: .setting)
        newRequestLeaveAndBookSlotVC.modalTransitionStyle = .crossDissolve
        newRequestLeaveAndBookSlotVC.modalPresentationStyle = .overFullScreen
        self.present(newRequestLeaveAndBookSlotVC, animated: true, completion: nil)
    }
}

extension BookSlotsAndleaveVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblViewHistory.dequeueReusableCell(withIdentifier: BoolSlotAndLeaveTblCell.identifire, for: indexPath) as? BoolSlotAndLeaveTblCell else {
            return UITableViewCell()
        }
        return cell
    }
}
