//
//  UploadedDocumentsVC.swift
//  Max
//
//  Created by Rahul on 20/12/21.
//

import UIKit

class UploadedDocumentsVC: MaxBaseVC,setDelegate {
    
    var viewModelDoc = UploadedDocViewModel()
    
    func cellTaped(data: String) {
        
        
        viewModelDoc.getDocData(DataId:data ){
            
            let viewDocumentsVC: ViewDocViewC = ViewDocViewC.instantiate(appStoryboard: .dashboard)
            viewDocumentsVC.strUrl = self.viewModelDoc.getResult
            self.navigationController?.pushViewController(viewDocumentsVC, animated: true)
            
        }
        
               
    }
    
   
    var patientPii:Pii?
    var iscomingFrom = ""
    var viewModel = UploadedPrescriptionViewModel()
    @IBOutlet weak var heightOfViewshowDate: NSLayoutConstraint!
    
    @IBOutlet weak var viewShowHide: UIView!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblMobile: UILabel!
    //MARK:-IBOutlet
    @IBOutlet weak var tblUploadedDocument: UITableView!
    

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        patientPii?.id
        viewModel.getPrescriptionData(AppointmentId:"38f45aac-d32f-4b6c-8b0c-a8570b6b6699" ?? "", PatientId: patientPii?.patient_id ?? ""){
            self.tblUploadedDocument.reloadData()
            
        }
        
        if !iscomingFrom.isEmpty{
            heightOfViewshowDate.constant = 180
            viewShowHide.isHidden = false
            lblHeader.text = patientPii?.name
            lblMobile.text = patientPii?.mobile
        }
        
    }
    
    //MARK:-Action
}

extension UploadedDocumentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblUploadedDocument.dequeueReusableCell(withIdentifier: TblUploadedDocumentCell.identifire, for: indexPath) as? TblUploadedDocumentCell else {
            return UITableViewCell()
        }
        let data = viewModel.getItem(row: indexPath.row)
        
        cell.lblTitle.text = data?[indexPath.row].type
        cell.viewModel = viewModel
        cell.delegate = self
        return cell
    }
}
