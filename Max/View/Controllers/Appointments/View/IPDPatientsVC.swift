//
//  IPDPatientsVC.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class IPDPatientsVC: MaxBaseVC {
    var viewModel = IPdPatientViewModel()
    var branchId:String = ""
    var ipdDate:String = ""
    //MARK:-IBOutlet
    @IBOutlet weak var lblHospitalName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblIPDPatients: UITableView!//cell 96
    
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDate.text = AuthManager.shared.visibleDate
        viewModel.getIpDPatient(BranchId: branchId, IpdDate: ipdDate) {
            print("=====Successfully Done IPD Patient========")
//            self.setUpView()
         self.tblIPDPatients.reloadData()
        }
    }
    
    //MARK:-Action
}

extension IPDPatientsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblIPDPatients.dequeueReusableCell(withIdentifier: TblIPDPatientsCell.identifire, for: indexPath) as? TblIPDPatientsCell else {
            return UITableViewCell()
        }
        cell.vwTag.arrData = ["Cash","Primary"]
        let pii = viewModel.getPatientPii(section: indexPath.section, row: indexPath.row)

        cell.lblPatientsName.text = pii?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pii = viewModel.getPatientPii(section: indexPath.section, row: indexPath.row)

        let uploadedDocumentsVC: UploadedDocumentsVC = UploadedDocumentsVC.instantiate(appStoryboard: .dashboard)
        uploadedDocumentsVC.iscomingFrom = "IPDPatientsVC"
        uploadedDocumentsVC.patientPii = pii
        self.navigationController?.pushViewController(uploadedDocumentsVC, animated: true)
        
    }
}
