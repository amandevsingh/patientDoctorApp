//
//  AppointmentVC.swift
//  Max
//
//  Created by Rahul on 16/12/21.
//

import UIKit

class AppointmentVC: UIViewController {
    
    //MARK:-IBOutlet
    @IBOutlet weak var lblGreetingMsg: UILabel!
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var tblAppointments: UITableView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var noAppointmentView: UIView!
    
    var viewModel = AppointmentViewModel()
    var arrSection: [String] = ["Max Saket","Max Vaishali"]
    
    lazy var dateformatterForDateAndMonth: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM"
        return dateformatter
    }()
    
    lazy var yearDateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YY"
        return dateformatter
    }()
    
    lazy var dateInTimeInterval: TimeInterval = {
        return currentPage?.timeIntervalSince1970 ?? 0.0
    }()
    
    
    func dateInYYYYMMDD() -> String {
        //currentPage
        let date = currentPage//currentPage?.toLocalTime() ?? Date()
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "YYYY-MM-dd"
        // Convert Date to String
        return dateFormatter.string(from: date ?? Date())
    }
    
    var currentPage: Date?
    
    lazy var today: Date = {
        return Date()
    }()
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- register cell
        tblAppointments.register(UINib(nibName: "AppointmentHeaderViewTableViewCell", bundle: nil), forCellReuseIdentifier: "AppointmentHeaderViewTableViewCell")
        
        //MARK:- Set current shown date
        self.currentPage = today
        self.lblCurrentDate.text = getVisibleDate()
        AuthManager.shared.visibleDate = getVisibleDate()
        
        //    print(Environment().configuration(PlistKey.serverURL))
        
        //"2022-01-24"
        //
        viewModel.getAppointment(AppointmentDate: dateInYYYYMMDD(), BranchWiseCount: true) {
            print("=====Successfully get Appointment========")
            self.setUpView()
            self.noAppointmentView.isHidden = !(self.viewModel.sectionCount == 0)
            self.tblAppointments.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        getAppointment(doctorId: "4c686467-59ed-4f13-8ab0-9563642b930d", appointmentDate: "2022-01-24", branchWiseCount: "true", calenderView: "false")
    }
    
    func setUpView(){
        lblDoctorName.text = AuthManager.shared.userData?.name
    }
    
    func getVisibleDate() -> String {
        var currentVisibleDate = ""
        if Calendar.current.isDateInToday(currentPage ?? today) {
            currentVisibleDate.append("Today, ")
        }else if Calendar.current.isDateInTomorrow(currentPage ?? today) {
            currentVisibleDate.append("Tomorrow, ")
        }else if Calendar.current.isDateInYesterday(currentPage ?? today) {
            currentVisibleDate.append("Yesterday, ")
        }else {
            currentVisibleDate = ""
        }
        let dateAndMonth =  self.dateformatterForDateAndMonth.string(from: currentPage ?? today)
        currentVisibleDate.append("\(dateAndMonth)' ")
        
        let year = self.yearDateFormatter.string(from: currentPage ?? today)
        currentVisibleDate.append(year)
        
        return currentVisibleDate//"Today, 26 Oct'21"
    }
    
    //MARK:- IBAction
    @IBAction func newAppointmentButtonAction(_ sender: Any) {
        let vc =   dashboardStoryboard.instantiateViewController(withIdentifier: "AddAppointmentVC") as! AddAppointmentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:-Action
    @IBAction func btnMessageTapped(_ sender: UIButton) {
        //Utility.moveToLogin((SceneDelegate.shared?.window!)!)
//        let callPatientPopUpVC: SelectDoctorsVC = SelectDoctorsVC.instantiate(appStoryboard: .dashboard)
//        callPatientPopUpVC.modalTransitionStyle = .crossDissolve
//        callPatientPopUpVC.modalPresentationStyle = .overCurrentContext
//        self.present(callPatientPopUpVC, animated: true, completion: nil)
        
        
        let vc =   dashboardStoryboard.instantiateViewController(withIdentifier: "RescheduleAppointmentVC") as! RescheduleAppointmentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCalendarBackwardTapped(_ sender: UIButton) {
        self.currentPage =  Calendar.current.date(byAdding: .day, value: -1, to: self.currentPage ?? today)!
        self.lblCurrentDate.text = getVisibleDate()
        AuthManager.shared.visibleDate = getVisibleDate()
        
        viewModel.getAppointment(AppointmentDate: dateInYYYYMMDD(), BranchWiseCount: true) {
            print("=====Successfully get Appointment========")
            self.noAppointmentView.isHidden = !(self.viewModel.sectionCount == 0)
            self.tblAppointments.reloadData()
        }
    }
    
    @IBAction func btnCalendarForwardTapped(_ sender: UIButton) {
        self.currentPage =  Calendar.current.date(byAdding: .day, value: 1, to: self.currentPage ?? today)!
        self.lblCurrentDate.text = getVisibleDate()
        AuthManager.shared.visibleDate = getVisibleDate()
        
        viewModel.getAppointment(AppointmentDate: dateInYYYYMMDD(), BranchWiseCount: true) {
            print("=====Successfully get Appointment========")
            self.noAppointmentView.isHidden = !(self.viewModel.sectionCount == 0)
            self.tblAppointments.reloadData()
        }
    }
    
    @IBAction func btnCalendarOpenTapped(_ sender: UIButton) {
        shouldDisableTabbar(value: true)
        //MARK:- Present Calandar View
        let vc = dashboardStoryboard.instantiateViewController(withIdentifier: "AppointmentCalendarViewController") as! AppointmentCalendarViewController
        self.definesPresentationContext = true
        vc.modalPresentationStyle = .overCurrentContext
        vc.completion = {
            self.shouldDisableTabbar(value: false)
        }
        self.present(vc, animated: true)
    }
}

//MARK:- Disable Tabbar
extension AppointmentVC {
    
    private func shouldDisableTabbar(value: Bool){
        if  let arrayOfTabBarItems = self.tabBarController?.tabBar.items as AnyObject as? NSArray {
            for item in arrayOfTabBarItems {
                (item as! UITabBarItem).isEnabled = !value
            }
        }
    }
}

extension AppointmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount //arrSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: AppointmentHeaderViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentHeaderViewTableViewCell") as! AppointmentHeaderViewTableViewCell
        cell.appointmentHeaderLabel.text = viewModel.titleForSection(section: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount(section: section)
        //return section == 0 ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.requestItem(section: indexPath.section, row: indexPath.row)!
        guard let cell = tblAppointments.dequeueReusableCell(withIdentifier: TblAppointmentTypeCell.identifire, for: indexPath) as? TblAppointmentTypeCell else {
            return UITableViewCell()
        }
        cell.configure(currentRow:indexPath.row,lastIndex:viewModel.rowCount(section: indexPath.section) - 1,item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.requestItem(section: indexPath.section, row: indexPath.row)!
        
        if item.appointment_type?.uppercased() == "OPD"{
            let opdPatientsVC: OPDPatientsVC = OPDPatientsVC.instantiate(appStoryboard: .dashboard)
            opdPatientsVC.branchId = viewModel.branchId(section: indexPath.section)
            opdPatientsVC.opdTiming = "(\(item.slot_start_time ?? "") - \(item.slot_end_time ?? ""))"
            opdPatientsVC.opdDate = viewModel.ipdDate(section: indexPath.section)
            self.navigationController?.pushViewController(opdPatientsVC, animated: true)
        }else{
            let ipdPatientsVC: IPDPatientsVC = IPDPatientsVC.instantiate(appStoryboard: .dashboard)
            ipdPatientsVC.branchId = viewModel.branchId(section: indexPath.section)
            ipdPatientsVC.ipdDate = viewModel.ipdDate(section: indexPath.section)
            self.navigationController?.pushViewController(ipdPatientsVC, animated: true)
        }
        
    }
}



