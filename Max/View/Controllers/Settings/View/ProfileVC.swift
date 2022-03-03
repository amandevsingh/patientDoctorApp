//
//  ProfileVC.swift
//  Max
//
//  Created by Rahul on 04/01/22.
//

import UIKit
import Kingfisher


class ProfileVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblUserMobileNumber: UILabel!
    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblSupportNo: UITextField!
    @IBOutlet weak var imgDropDown: UIImageView!

     //MARK:- Variables
    var profileViewModel = ProfileViewModel()

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.getProfileData {
        self.setUpProfile()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func setUpProfile() {
       //imgUser.image = profileViewModel.getUserImage
        lblUserName.text = profileViewModel.getUserName
        lblUserMobileNumber.text = profileViewModel.getUserMobileNumber
        lblExperience.text =  profileViewModel.getExperience
        lblSpeciality.text = profileViewModel.speciality
        lblUserEmail.text = profileViewModel.emailId
        //lblSupportNo.text = profileViewModel.getSupportMobileNumber
    }

    //MARK:-Action
    @IBAction func btnMyTeamMemberTapped(_ sender: UIButton) {

    }
}
