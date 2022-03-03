//
//  RescheduleAppointmentVC.swift
//  Max
//
//  Created by Satyam Kumar on 02/03/22.
//

import UIKit

class RescheduleAppointmentVC: UIViewController {
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var doctorDetailsLbl: UILabel!
    @IBOutlet weak var doctorQulificationLbl: UILabel!
    @IBOutlet weak var doctorCurrentApptTimeLbl: UILabel!
    @IBOutlet weak var doctorVideoConsultationTimeLbl: UILabel!
    @IBOutlet weak var doctorNewApptSlotDateCollView: UICollectionView!
    @IBOutlet weak var doctorNewApptSlotTimeCollView: UICollectionView!
    var dateSlot = [["day":"Today","slot":"20 Slot"],["day":"Tomorrow","slot":" 20 Slots"],["day":"6 Oct’21","slot":"20 Slots"]]
}
//MARK: - Life Cycle
extension RescheduleAppointmentVC{
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
//MARK: - Action
extension RescheduleAppointmentVC{
    @IBAction func backBtn(_ sender:UIButton){
        
    }
    @IBAction func reshscheduleBtn(_ sender: UIButton){
                let CannotRescheduleDirectlyVC: CannotRescheduleDirectlyVC = CannotRescheduleDirectlyVC.instantiate(appStoryboard: .dashboard)
        CannotRescheduleDirectlyVC.modalTransitionStyle = .crossDissolve
        CannotRescheduleDirectlyVC.modalPresentationStyle = .overCurrentContext
                self.present(CannotRescheduleDirectlyVC, animated: true, completion: nil)
    }
}
//MARK: - Delegate and DataSource
extension RescheduleAppointmentVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == doctorNewApptSlotDateCollView{
            return dateSlot.count
        }
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == doctorNewApptSlotDateCollView{
            let cell =  doctorNewApptSlotDateCollView.dequeueReusableCell(withReuseIdentifier: "ApptDateSlotsCollectionViewCell", for: indexPath) as! ApptDateSlotsCollectionViewCell
            let data = dateSlot[indexPath.row]
            cell.daysLabel!.text! = data["day"]!
            cell.totalSlotCountLabel!.text! = data["slot"]!
            return cell
        }
        let cell =  doctorNewApptSlotTimeCollView.dequeueReusableCell(withReuseIdentifier: "ApptTimeSlotsCollectionViewCell", for: indexPath) as! ApptTimeSlotsCollectionViewCell
        return cell
    }
    
    
    
}
extension RescheduleAppointmentVC:UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == doctorNewApptSlotTimeCollView
        {
        if let cell = doctorNewApptSlotTimeCollView.cellForItem(at: indexPath)as? ApptTimeSlotsCollectionViewCell{
          
            cell.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.7254901961, blue: 0.7058823529, alpha: 1)
            cell.timeLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
                   }
        }
        if collectionView == doctorNewApptSlotDateCollView
        {
        if let cell = doctorNewApptSlotDateCollView.cellForItem(at: indexPath)as? ApptDateSlotsCollectionViewCell{
          
            cell.layer.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.8549019608, blue: 0.9058823529, alpha: 1)
            
            
                   }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == doctorNewApptSlotTimeCollView
        {
        if let cell = doctorNewApptSlotTimeCollView.cellForItem(at: indexPath) as? ApptTimeSlotsCollectionViewCell{
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.timeLbl.textColor = #colorLiteral(red: 0, green: 0.2196078431, blue: 0.4705882353, alpha: 1)
        }
        }
        if collectionView == doctorNewApptSlotDateCollView
        {
        if let cell = doctorNewApptSlotDateCollView.cellForItem(at: indexPath)as? ApptDateSlotsCollectionViewCell{
          
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            
                   }
        }
    }
}
//MARK: - Custom UICollectionViewFlowLayout
class CustomCollectionView: UICollectionView {
    
    private let numberOfCellsPerRow = 3
    private let spacing: CGFloat = 10
    
    private var flowLayout: UICollectionViewFlowLayout? {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        sharedInit()
        updateItemSize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
        updateItemSize()
    }
    
    private func sharedInit() {
        flowLayout?.minimumInteritemSpacing = spacing
        flowLayout?.minimumLineSpacing = spacing
    }
    
    
    private func updateItemSize() {
        let cellWidth = floor((bounds.width - (CGFloat(numberOfCellsPerRow) - 1) * spacing) / CGFloat(numberOfCellsPerRow))
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            if UIDevice.current.orientation.isPortrait {
//                flowLayout?.itemSize = CGSize(width: cellWidth, height: (cellWidth - 120) )
//            }
//            if UIDevice.current.orientation.isLandscape {
//                flowLayout?.itemSize = CGSize(width: cellWidth, height: (cellWidth-230) )
//            }
//
//        }else{
            if UIDevice.current.orientation.isPortrait {
                flowLayout?.itemSize = CGSize(width: cellWidth-10, height: 40 )
            }
           
       // }
        
        flowLayout?.invalidateLayout()
    }
    
    override var bounds: CGRect {
        didSet {
            if bounds != oldValue {
                updateItemSize()
            }
        }
    }
}
