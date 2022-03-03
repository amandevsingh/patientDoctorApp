//
//  AppointmentCalendarViewController.swift
//  Max
//
//  Created by Ankit on 19/01/22.
//

import UIKit
import FSCalendar
import CalendarKit

class AppointmentCalendarViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var topCloseCalendarButton: UIButton!
    @IBOutlet weak var closeCalendarButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var monthLabel: UILabel!

    //MARK:- Variables
    var completion : (() -> ())?
    let viewModel = AppointmentCalendarViewModel()
    var selectedDate: Date = Date()
    lazy var today: Date = {
        return Date()
    }()
    var calender: FSCalendar = {
        let calendar = FSCalendar()
        calendar.formatter.timeZone = .current
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    var currentPage: Date?
    lazy var shortDateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = .current
        dateformatter.dateFormat = "MMM"
        return dateformatter
    }()
    lazy var shortDateYYYYMMddFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = .current
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter
    }()
/*
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
 */

    lazy var dateformatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = .current
        dateformatter.dateFormat = "MMMM"//"MMM YYYY"
        return dateformatter
    }()
    var showAnimation: Bool = true
    var isLeftOrRightCalendarButtonTapped: Bool = false
}

//MARK:- View Lifecycle methods
extension AppointmentCalendarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateView()
    }
}

//MARK:- Private functions
extension AppointmentCalendarViewController {

    fileprivate func animateView(){
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.topConstraint.constant = 549
                self.view.layoutIfNeeded()
        }) { _ in
            self.showAnimation.toggle()
            self.closeCalendarButton.isHidden = self.showAnimation
            self.topCloseCalendarButton.isHidden = !self.showAnimation
        }
    }
    fileprivate func initialSetUp(){
        initialSetUpForCalendar()
    }

    fileprivate func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        let monthName = self.dateformatter.string(from: self.currentPage ?? self.today)

        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentPage ?? today) ?? Date()
        let nextMonth = self.shortDateFormatter.string(from: nextMonthDate)
        let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentPage ?? today) ?? Date()
        let previousMonth = self.shortDateFormatter.string(from: previousMonthDate)
        self.previousButton.setTitle(previousMonth, for: .normal)
        self.nextButton.setTitle(nextMonth, for: .normal)
        self.monthLabel.text = monthName
        DispatchQueue.main.async {
            self.calender.setCurrentPage(self.currentPage!, animated: true)
        }
    }

    fileprivate func initialSetUpForCalendar() {
        let monthName = self.dateformatter.string(from: self.currentPage ?? self.today)
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        let nextMonth = self.shortDateFormatter.string(from: nextMonthDate)
        let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        let previousMonth = self.shortDateFormatter.string(from: previousMonthDate)

        self.previousButton.setTitle(previousMonth, for: .normal)
        self.nextButton.setTitle(nextMonth, for: .normal)
        self.monthLabel.text = monthName
        self.calendarView.addSubview(calender)
       //calander.frame = CGRect(x: 0, y: 0, width: self.calendarView.frame.width, height: self.calendarView.frame.height)
        calender.centerXAnchor.constraint(equalTo: self.calendarView.centerXAnchor, constant: 0).isActive = true
        calender.centerYAnchor.constraint(equalTo: self.calendarView.centerYAnchor, constant: 0).isActive = true
        calender.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 0).isActive = true
        calender.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: 0).isActive = true
        calender.heightAnchor.constraint(equalToConstant: 350).isActive = true

        calender.dataSource = self
        calender.delegate = self

        //set first week day
        calender.firstWeekday = 2

        //header color
        calender.headerHeight = 0
        calender.appearance.headerTitleColor = .white
        calender.appearance.headerTitleFont =
         UIFont.proximaNovaSemiBold(of: 14)

        //week text Color
        calender.appearance.weekdayTextColor =  UIColor(red: 0.086, green: 0.231, blue: 0.427, alpha: 0.5)//UIColor(hex: "163B6D")//.black//.white
        calender.appearance.weekdayFont = UIFont.proximaNovaSemiBold(of: 14)
        //calender.appearance.caseOptions = .weekdayUsesUpperCase
//        DispatchQueue.main.async {
//            self.calender.calendarWeekdayView.weekdayLabels[5].textColor = UIColor().coloWithHexString(hex: "#814148", alpha: 1)
//        }

        //Title Color
        calender.appearance.titleDefaultColor = UIColor(hex: "8A9DB6")
        //UIColor(hex: "#4DA9D0") //UIColor().coloWithHexString(hex: "#ffffff", alpha: 0.3)
        calender.appearance.titleSelectionColor = .white//UIColor(hex: "4DA9D0")
        calender.appearance.selectionColor = UIColor(hex: "4DA9D0") //.clear
        calender.appearance.titleOffset.y = 12
        calender.appearance.todayColor = UIColor(hex: "4DA9D0")//.clear



        //register cell here
        calender.register(CalendarCollectionViewCell.self, forCellReuseIdentifier: "Cell")
       // calander.register(DayDateCell.self, forCellReuseIdentifier: "Cell")

    }
}

    //MARK:- IBActions
    extension AppointmentCalendarViewController {

        @IBAction func closeCalaendarButtonAction(_ sender: UIButton) {
          self.dismiss(animated: true, completion: {
              self.completion?()
          })
        }

        @IBAction func chatButtonAction(_ sender: UIButton) {
            let vc = ChatListVC.instantiate(appStoryboard: .chat) as! ChatListVC
            vc.presentation = .present
            present(vc, animated: true, completion: nil)
        }

        @IBAction func previousButtonAction(_ sender: UIButton) {
            isLeftOrRightCalendarButtonTapped = true
            moveCurrentPage(moveUp: false)
        }

        @IBAction func nextButtonAction(_ sender: UIButton) {
            isLeftOrRightCalendarButtonTapped = true
            moveCurrentPage(moveUp: true)
        }
    }

//MARK:- FSCalendar delegates
extension AppointmentCalendarViewController :FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    //Disable the previous month dates
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if monthPosition == .current {
            return true
        }else {
            return false
        }
    }

    //MARK:- Setting minimum date for calendar to today
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }

    //MARK:- On calendar change
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

        if !isLeftOrRightCalendarButtonTapped {
     moveCurrentPage(moveUp: calendar.currentPage > currentPage ?? today)
        }
        isLeftOrRightCalendarButtonTapped = false
        self.calender.deselect(self.selectedDate)
    }

    //MARK:- Provide customise cell here
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position) as! CalendarCollectionViewCell
        //cell.isSelectedDate = (self.selectedDate == date)
        print(self.selectedDate)

        let selectedDateInString = selectedDate.timeIntervalSince1970
        let dateInString = date.timeIntervalSince1970

        cell.selectionType = (dateInString == selectedDateInString) ? .middle : .none
        //(self.selectedDate.toLocalTime() == date.toLocalTime()) ? .middle : .none
       return cell
    }

    //MARK:- didSelect
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

//        if let cell = calendar.cell(for: date, at: .current) {
//            self.selectedDate = date
//            let index = calendar.collectionView.indexPath(for: cell as UICollectionViewCell)!
//            calendar.collectionView.reloadItems(at: [index])
//        }
//        calendar.deselect(date)
        if let cell = calendar.cell(for: date, at: .current) {
        if monthPosition == .current {

         calendar.deselect(self.selectedDate)
         self.selectedDate = date//date.toLocalTime()
            //calendar.select(date)

            let index = calendar.collectionView.indexPath(for: cell as UICollectionViewCell)!
            calendar.collectionView.reloadItems(at: [index])
           // calendar.reloadData()
        //calendar.layoutIfNeeded()
        }
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let currentSelectedCell = calendar.cell(for: self.selectedDate, at: .current) {
            let currentSelectedIndex = calendar.collectionView.indexPath(for: currentSelectedCell as UICollectionViewCell)!
            calendar.collectionView.reloadItems(at: [currentSelectedIndex])
        }
    }
}



