//
//  OPDPatientsVC.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//



import UIKit

class OPDPatientsVC: MaxBaseVC {

    //MARK:-IBOutlet
    @IBOutlet weak var lblHospitalName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblOPDPatients: UITableView!
    @IBOutlet weak var collOPD: UICollectionView!//cell 116
    @IBOutlet weak var lblInfoAboutPractice: UILabel!
    @IBOutlet weak var btnStartPractice: UIButton!
    @IBOutlet weak var consHeightStartPractice: NSLayoutConstraint!//100WL,80WOL
    @IBOutlet weak var consHeightHeader: NSLayoutConstraint!//236,220,140
    @IBOutlet weak var vwFooter: UIView!//84,176
    @IBOutlet weak var btnEndPractice: UIButton!
    @IBOutlet weak var timeLabel: UILabel!

    var branchId:String = ""
    var opdDate:String = ""
    var opdTiming: String = ""
    var doctorSlotConfigId = "cf2ac90d-5c3f-4821-b5e4-69614d088820"
    let opdViewModel = OpdPatientViewModel()

    //var selectedIndex = 0
    var selectedIndex :CollectionViewTitleEnum = .checked_in

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(opdTiming)"
        opdViewModel.getOPDData(BranchId: branchId, OpdDate: opdDate) { [weak self] in
            self?.loadUI()
            self?.tblOPDPatients.reloadData()
            self?.collOPD.reloadData()
        }
        
        opdViewModel.getDoctorSlotConfig(doctorSlotConfigId: doctorSlotConfigId) { [weak self] in
            
            print("doctorConfig id")
            var btnStatus = self?.opdViewModel.getPractice_status == "stop" ? "Start Practice" : "Stop Practice"
            
            self?.btnStartPractice.setTitle(btnStatus, for: .normal)
        }
    }

    //MARK:- Setup view
    func loadUI() {
        switch selectedIndex {
            case .checked_in:
                lblInfoAboutPractice.text = ""
                consHeightStartPractice.constant = 80
                btnStartPractice.isHidden = false
                consHeightHeader.constant = 220
                vwFooter.frame.size.height = 84
                btnEndPractice.isHidden = true
                self.lblDate.text = AuthManager.shared.visibleDate
            default:
                lblInfoAboutPractice.text = ""
                btnStartPractice.isHidden = true
                consHeightStartPractice.constant = 0
                consHeightHeader.constant = (220 - 80)
                vwFooter.frame.size.height = 0
                btnEndPractice.isHidden = true
                self.lblDate.text = AuthManager.shared.visibleDate
        }
    }
    
    //MARK:-Action
    @IBAction func btnStartPracticeTapped(_ sender: UIButton) {
        /* 160(Header without consHeightStartPractice),240(Header with consHeightStartPractice and without info lalbe),260((Header with consHeightStartPractice and info lable))
         */
//        if sender.titleLabel?.text == "Start Practice" {
//            vwFooter.frame.size.height = 176
//            btnEndPractice.isHidden = false
//            consHeightHeader.constant = 140
//            consHeightStartPractice.constant = 0
//            tblOPDPatients.reloadData()
//        } else {
//
//        }
        
        if sender.titleLabel?.text == "Start Practice" {
            
            opdViewModel.getPracticeUpdate(doctorSlotConfigId: doctorSlotConfigId, practiceStatus: "stop") { [weak self] in
               
                self?.btnStartPractice.setTitle("Stop Practice", for: .normal)
            }
            
        }else
        {
        opdViewModel.getPracticeUpdate(doctorSlotConfigId: doctorSlotConfigId, practiceStatus: "start") { [weak self] in
          
            self?.btnStartPractice.setTitle("Start Practice", for: .normal)
        }
      }
    }
    
    @IBAction func btnEndPracticeTapped(_ sender: UIButton) {
//        if btnStartPractice.titleLabel?.text == "Re-Start Practice" {
//
//        } else {
//            lblInfoAboutPractice.text = "Your practice is paused temporarily"
////            btnStartPractice.setTitle("Re-Start Practice", for: .normal)
//            consHeightHeader.constant = 236
//            consHeightStartPractice.constant = 100
//            vwFooter.frame.size.height = 84
//            btnEndPractice.isHidden = true
//            tblOPDPatients.reloadData()
//        }
        
        opdViewModel.getPracticeUpdate(doctorSlotConfigId: doctorSlotConfigId, practiceStatus: "stop") { [weak self] in
            print("doctorConfig id")
            var btnStatus = self?.opdViewModel.getPractice_status == "stop" ? "Start Practice" : "Stop Practice"
            self?.btnStartPractice.setTitle(btnStatus, for: .normal)
        }
    }
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        let addAppointmentVC: AddAppointmentVC = AddAppointmentVC.instantiate(appStoryboard: .dashboard)
        self.navigationController?.pushViewController(addAppointmentVC, animated: true)
    }
}
 
extension OPDPatientsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opdViewModel.getTableViewRowCount(selectedIndex: selectedIndex)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblOPDPatients.dequeueReusableCell(withIdentifier: TblOPDPatientsCell.identifire, for: indexPath) as? TblOPDPatientsCell else {
            return UITableViewCell()
        }
        switch selectedIndex {
            case .checked_in:
            btnStartPractice.isHidden = false
            break
            case .total_appts:
            cell.lblPatientsAge.text = opdViewModel.getFormattedAgeAndGender(index: indexPath.row)
            btnStartPractice.isHidden = true
        let pii = opdViewModel.getOPDPatient(index: indexPath.row)
        cell.vwTag.arrData = ["Cash","Primary"]
        cell.lblPatientsName.text = pii.name
            case .no_Show_Cancel:
        btnStartPractice.isHidden = true
            break
            case .checked_out:
        btnStartPractice.isHidden = true
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {


            switch selectedIndex {
                case .checked_in:
                    return nil

                case .total_appts:
                    let pii = opdViewModel.getOPDPatient(index: indexPath.row)

                    let startConslut = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
                        completionHandler(true)

                       // if indexPath.row == 0 {
                            let pateintDetailVC: PateintDetailVC = PateintDetailVC.instantiate(appStoryboard: .dashboard)
                        pateintDetailVC.patientDetail = (appointmentID: self.opdViewModel.getAppointmentID(index: indexPath.row),patientID: pii.patient_id)
                        pateintDetailVC.patientName = self.opdViewModel.getPatientName(index: indexPath.row)
                        pateintDetailVC.mobileNumber = self.opdViewModel.getPatientMobileNumber(index: indexPath.row)
                        pateintDetailVC.ageAndGender = self.opdViewModel.getFormattedAgeAndGender(index: indexPath.row)

                        self.navigationController?.pushViewController(pateintDetailVC, animated: true)
                       // }
                    }

                    startConslut.image = #imageLiteral(resourceName: "AStartConsult")
//                    switch indexPath.row {
//                    case 0:
//                        startConslut.image = #imageLiteral(resourceName: "AStartConsult")
//                    case 1:
//                        startConslut.image = #imageLiteral(resourceName: "AEndConsult")
//                    case 2:
//                        startConslut.image = #imageLiteral(resourceName: "ACheckIn")
//                    case 3:
//                        startConslut.image = #imageLiteral(resourceName: "AReCheckIn")
//                    default:
//                        break
//                    }
                    startConslut.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9215686275, blue: 0.9450980392, alpha: 1)
                    let swipeConfiguration = UISwipeActionsConfiguration(actions: [startConslut])
                    return swipeConfiguration


                case .no_Show_Cancel:
                    return nil
                case .checked_out:
                    return nil
            }
}
}

extension OPDPatientsVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return opdViewModel.getCollectionViewTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collOPD.dequeueReusableCell(withReuseIdentifier: CollOPDCell.identifire, for: indexPath) as? CollOPDCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(type: (opdViewModel.getCollectionViewTitle[indexPath.row]))
        cell.backgroundColor = (selectedIndex == opdViewModel.getCollectionViewTitle[indexPath.row].0) ? #colorLiteral(red: 0.7568627451, green: 0.8549019608, blue: 0.9098039216, alpha: 1):#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = opdViewModel.getCollectionViewTitle[indexPath.row].0
        collOPD.scrollToItem(at: indexPath, at: .left, animated: .random())
        self.collOPD.reloadData()
        self.loadUI()
        DispatchQueue.main.async {
            self.tblOPDPatients.reloadData()
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 99, height: 64)
    }
}
