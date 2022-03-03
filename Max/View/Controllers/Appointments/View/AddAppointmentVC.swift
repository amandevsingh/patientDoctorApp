//
//  AddAppointmentVC.swift
//  Max
//
//  Created by Rahul on 24/12/21.
//

import UIKit
import DropDown

class AddAppointmentVC: MaxBaseVC {
    
    //MARK:-IBOutlet
    @IBOutlet weak var tblAddAppointment: UITableView!
    @IBOutlet weak var vwMain: UIView!//FH 1600
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnAppointmentType: UIButton!
    @IBOutlet weak var btnAppointmentDate: UIButton!
    @IBOutlet weak var btnAppointmentTime: UIButton!
    @IBOutlet weak var txtPatientNumber: UITextField!
    @IBOutlet weak var lblNumberPatientOnThisPhone: UILabel!
    @IBOutlet weak var btnChoosePatient: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var btnNationality: UIButton!
    @IBOutlet weak var txtEmailID: UITextField!
    @IBOutlet weak var consHeightAddPatient: NSLayoutConstraint!//686
    @IBOutlet weak var consHeightPatientDetails: NSLayoutConstraint!//964
    
    let hospitalDropDown = DropDown()
    let appointmentTypeDropDown = DropDown()
    let genderDropDown = DropDown()
    let choosePatienrDropDown = DropDown()
    let nationalityDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] =  {
        return [hospitalDropDown,appointmentTypeDropDown,genderDropDown,choosePatienrDropDown,nationalityDropDown]
    }()

    lazy var dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = .current
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter
    }()

    var addAppointmentViewModel = AddAppointmentViewModel()

    var totalNoOfAppointment : Int = 0 {
        didSet {
        self.lblNumberPatientOnThisPhone.isHidden = false
        self.lblNumberPatientOnThisPhone.text = "\(totalNoOfAppointment)" + (totalNoOfAppointment > 1 ? " patients" : " patient") + " found on this number"
        }
    }

    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        self.initialSetup()
    }

    func initialSetup() {
        totalNoOfAppointment = 0
        self.lblNumberPatientOnThisPhone.isHidden = true

        addAppointmentViewModel.getBranch { [weak self] in
            DispatchQueue.main.async {
                self?.hospitalDropDown.dataSource = self?.addAppointmentViewModel.getBranchList() ?? []
                self?.btnHospital.setTitle(self?.hospitalDropDown.dataSource.first ?? "", for: .normal)
                self?.addAppointmentViewModel.setSelectedBranch(index: 0)
            }
        }
        addAppointmentViewModel.getNationality{ [weak self] in
            DispatchQueue.main.async {
            self?.nationalityDropDown.dataSource = self?.addAppointmentViewModel.getNationality() ?? []
                self?.btnNationality.setTitle(self?.nationalityDropDown.dataSource.first ?? "", for: .normal)
                self?.addAppointmentViewModel.setSelectedNation(index: 0)
            }
        }
        addAppointmentViewModel.getProcedures{ [weak self] in
            DispatchQueue.main.async {
            self?.appointmentTypeDropDown.dataSource = self?.addAppointmentViewModel.getProcedures() ?? []
                self?.btnAppointmentType.setTitle(self?.appointmentTypeDropDown.dataSource.first ?? "", for: .normal)
                self?.addAppointmentViewModel.setSelectedAppointment(index: 0)
            }
        }
    }

    func loadUI() {
        setUpDropDowns()
        vwMain.frame.size.height = 1600 - 686
        consHeightAddPatient.constant = 0
        consHeightPatientDetails.constant = 964 - 686
    }
    
    func setUpDropDowns() {
        btnAppointmentTime.isUserInteractionEnabled = false
        hospitalDropDown.anchorView = btnHospital
        hospitalDropDown.bottomOffset = CGPoint(x: 0, y: btnHospital.bounds.height)
        appointmentTypeDropDown.anchorView = btnAppointmentType
        appointmentTypeDropDown.bottomOffset = CGPoint(x: 0, y: btnAppointmentType.bounds.height)
        genderDropDown.anchorView = btnGender
        genderDropDown.bottomOffset = CGPoint(x: 0, y: btnGender.bounds.height)
        choosePatienrDropDown.anchorView = btnChoosePatient
        choosePatienrDropDown.bottomOffset = CGPoint(x: 0, y: btnChoosePatient.bounds.height)
        nationalityDropDown.anchorView = btnNationality
        nationalityDropDown.bottomOffset = CGPoint(x: 0, y: btnNationality.bounds.height)

        choosePatienrDropDown.dataSource = ((addAppointmentViewModel.getPatientList()?.count ?? 0) > 0) ? addAppointmentViewModel.getPatientList()! : ["+ Add New Patient"]

        hospitalDropDown.selectionAction = { [weak self] (index,item) in
            self?.btnHospital.setTitle(item, for: .normal)
            self?.addAppointmentViewModel.setSelectedBranch(index: index)
        }

        appointmentTypeDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnAppointmentType.setTitle(item, for: .normal)
            self?.addAppointmentViewModel.setSelectedAppointment(index: index)
        }
        genderDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnGender.setTitle(item, for: .normal)
        }
        choosePatienrDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnChoosePatient.setTitle(item, for: .normal)
            if item != "+ Add New Patient" {
                self?.vwMain.frame.size.height = 1600 - 686
                self?.consHeightAddPatient.constant = 0
                self?.consHeightPatientDetails.constant = 964 - 686
            self?.addAppointmentViewModel.setSelectedPatient(index: index)
            }
            if item == "+ Add New Patient" {

                self?.addAppointmentViewModel.getGender {
                    self?.genderDropDown.dataSource = self?.addAppointmentViewModel.getGenders() ?? []
                    self?.addAppointmentViewModel.setSelectedGender(index: 0)
                    self?.btnGender.setTitle(self?.genderDropDown.dataSource.first ?? "", for: .normal)
                }
                self?.vwMain.frame.size.height = 1600
                self?.consHeightAddPatient.constant = 686
                self?.consHeightPatientDetails.constant = 964
                self?.tblAddAppointment.reloadData()
            }
        }
        nationalityDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnNationality.setTitle(item, for: .normal)
        }
    }
    
    //MARK:-Action
    @IBAction func btnSelectHospitalTapped(_ sender: UIButton) {
        hospitalDropDown.show()
    }
    
    @IBAction func btnSelectAddAppointmentTypeTapped(_ sender: UIButton) {
        appointmentTypeDropDown.show()
    }
    
    @IBAction func btnAddAppointmentDateTapped(_ sender: UIButton) {
        btnAppointmentTime.setTitle("Please select a time", for: .normal)
        addAppointmentViewModel.setSelectedSlotToNil()

        RPicker.selectDate(title: "Select Appointment Date", didSelectDate: {[weak self] (selectedDate) in
            self?.btnAppointmentDate.setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
print(selectedDate)
            self?.btnAppointmentTime.isUserInteractionEnabled = true
            self?.addAppointmentViewModel.getSlots(date: self?.dateFormatter.string(from: selectedDate) ?? "") {

            }
        })
    }
    
    @IBAction func btnAddAppointmentTimeTapped(_ sender: UIButton) {

        let slots = addAppointmentViewModel.getSlots()
        if let slots = slots {
            if slots.count > 0{
        RPicker.selectOption(dataArray: slots) {[weak self] value, atIndex in
            self?.btnAppointmentTime.setTitle(value, for: .normal)
            self?.addAppointmentViewModel.setSelectedSlot(index: atIndex)
        }
            }
        }


//        RPicker.selectDate(title: "Select Appointment Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
//            self?.btnAppointmentTime.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
//        })
    }
    
    @IBAction func btnChoosePatientTapped(_ sender: UIButton) {
        choosePatienrDropDown.show()
    }
    
    @IBAction func btnSelectGenderTapped(_ sender: UIButton) {
        genderDropDown.show()
    }
    
    @IBAction func btnSelectDOBTapped(_ sender: UIButton) {

        RPicker.selectDate(title: "Select DOB", cancelText: "CANCEL", doneText: "DONE", datePickerMode: .date, selectedDate: Date().dateByAddingYears(-12), minDate: Date().dateByAddingYears(-120), maxDate: Date().dateByAddingYears(-12), style: .Wheel) { [weak self] (selectedDate) in
            self?.addAppointmentViewModel.setNewPatientDateOfBirth(dob: selectedDate)
            self?.btnDOB.setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
        }


//        RPicker.selectDate(title: "Select DOB", didSelectDate: {[weak self] (selectedDate) in
//            self?.addAppointmentViewModel.setNewPatientDateOfBirth(dob: selectedDate)
//            self?.btnDOB.setTitle(selectedDate.dateString("d MMM yy"), for: .normal)
//        })
    }
    
    @IBAction func btnSelectNationalityTapped(_ sender: UIButton) {
        nationalityDropDown.show()
    }

    @IBAction func searchButtonTapped(_ sender: UIButton?) {
        if !(txtPatientNumber.text?.trim().isEmpty ?? false) {
        addAppointmentViewModel.getPatientsByMobileNumber(mobileNumber: txtPatientNumber.text ?? "") { [weak self] in
            self?.choosePatienrDropDown.dataSource = ((self?.addAppointmentViewModel.getPatientList()?.count ?? 0) > 0) ? self?.addAppointmentViewModel.getPatientList() ?? [] : ["+ Add New Patient"]

            self?.totalNoOfAppointment = (self?.addAppointmentViewModel.getPatientList()?.count ?? 0) - 1
       }
      }
    }

    @IBAction func btnAddPatientTapped(_ sender: UIButton) {
        addAppointmentViewModel.checkAddPatientValidation(/txtFirstName.text, /txtLastName.text, /txtPhoneNumber.text, emailID: /txtEmailID.text) { errorMessage, value in
            if value {
            //hit api for add patient
                self.addAppointmentViewModel.addPatient {
                    self.txtPatientNumber.text = self.txtPhoneNumber.text
                    self.resetNewPatientDetail()
                    self.searchButtonTapped(nil)
                    self.vwMain.frame.size.height = 1600 - 686
                    self.consHeightAddPatient.constant = 0
                    self.consHeightPatientDetails.constant = 964 - 686
                    self.tblAddAppointment.reloadData()
                }
            } else {
                Utility.alertMessase(message: errorMessage, okAction: {}, controller: self)
            }
        }
    }

    func resetNewPatientDetail() {
        txtFirstName.text = nil
        txtLastName.text = nil
        txtPhoneNumber.text = nil
        txtEmailID.text = nil
        self.btnGender.setTitle(self.genderDropDown.dataSource.first ?? "", for: .normal)
        self.btnNationality.setTitle(self.nationalityDropDown.dataSource.first ?? "", for: .normal)
        self.btnDOB.setTitle(addAppointmentViewModel.getCurrentDate(), for: .normal)
    }

    @IBAction func btnAddAppointmentTapped(_ sender: UIButton) {
        self.addAppointmentViewModel.addAppointment {
        self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddAppointmentVC : UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 101 {//first name
            addAppointmentViewModel.setNewPatientFirstName(name: textField.text ?? "")
        }else if textField.tag == 102 {//last name
            addAppointmentViewModel.setNewPatientLastName(name: textField.text ?? "")
        }else if textField.tag == 103 {//phone number
            addAppointmentViewModel.setNewPatientMobileNumber(mobileNumber: textField.text ?? "")
        }else if textField.tag == 104 {//email-id
            addAppointmentViewModel.setNewPatientEmailID(email: textField.text ?? "")
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 100 {
            return true
        }
        return true
    }
}

