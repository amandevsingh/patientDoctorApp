    //
    //  PateintDetailVC.swift
    //  Max
    //
    //  Created by Rahul on 19/12/21.
    //

    import UIKit
    import BSImagePicker
    import Photos

    class PateintDetailVC: MaxBaseVC {

        //MARK:-IBOutlet
        @IBOutlet weak var lblPateintName: UILabel!
        @IBOutlet weak var lblPateintAge: UILabel!
        @IBOutlet weak var btnPateintContactNumber: UIButton!
        @IBOutlet weak var lblPateintID: UILabel!
        @IBOutlet weak var lblPateintType: UILabel!
        @IBOutlet weak var lblDateAndTime: UILabel!
        @IBOutlet weak var lblCheckedIn: UILabel!
        @IBOutlet weak var lblLastVisit: UILabel!
        @IBOutlet weak var btnAppointmentTime: UIButton!
        @IBOutlet weak var lblAppointmentStatus: UILabel!
        @IBOutlet weak var lblRecordsStatus: UILabel!
        @IBOutlet weak var lblPrescriptionsAndReportStats: UILabel!
        @IBOutlet weak var lblHealtIssuesStats: UILabel!
        @IBOutlet weak var lblCaseSummary: UILabel!
        @IBOutlet weak var lblLastPrescription: UILabel!
        @IBOutlet weak var lblLastReport: UILabel!
        @IBOutlet weak var lblLast4Prescription: UILabel!
        @IBOutlet weak var btnnoShow: UIButton!


       //MARK:- Variables
        let viewModel = PatientDetailViewModel()
        var patientDetail : (appointmentID: String?,patientID: String?) = (appointmentID: "0",patientID: "0")

        var patientName:String = ""
        var mobileNumber: String = ""
        var ageAndGender:String = "0,M"


        //MARK:-Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            lblPateintAge.text = ageAndGender
            btnPateintContactNumber.setTitle(mobileNumber, for: .normal)
            lblPateintName.text = patientName

            viewModel.getDocument(appointmentID: patientDetail.0 ?? "0", patientID: patientDetail.1 ?? "0") {
            }
            viewModel.getPatientDetail(appointmentID: patientDetail.0 ?? "0", patientID: patientDetail.1 ?? "0", type: "PRESCRIPTION") {
            }
            viewModel.getAppointment {
             self.btnnoShow.isHidden = self.viewModel.isnoShowHidden
            }
        }
    }

    //MARK:- IBActions
    extension PateintDetailVC {

        @IBAction func btnChatTapped(_ sender: UIButton) {

        }

        @IBAction func btnCallPateintTapped(_ sender: UIButton) {
            let callPatientPopUpVC: CallPatientPopUpVC = CallPatientPopUpVC.instantiate(appStoryboard: .dashboard)
            callPatientPopUpVC.modalTransitionStyle = .crossDissolve
            callPatientPopUpVC.modalPresentationStyle = .overCurrentContext
            self.present(callPatientPopUpVC, animated: true, completion: nil)
        }

        @IBAction func btnStartVideoCallTapped(_ sender: UIButton) {
            let joinVideoCallPopUpVC: JoinVideoCallPopUpVC = JoinVideoCallPopUpVC.instantiate(appStoryboard: .dashboard)
            joinVideoCallPopUpVC.modalTransitionStyle = .crossDissolve
            joinVideoCallPopUpVC.modalPresentationStyle = .overCurrentContext
            self.present(joinVideoCallPopUpVC, animated: true, completion: nil)
        }

        @IBAction func btnViewReportsAndPrescriptionsTapped(_ sender: UIButton) {
            let uploadedDocumentsVC: UploadedDocumentsVC = UploadedDocumentsVC.instantiate(appStoryboard: .dashboard)
            self.navigationController?.pushViewController(uploadedDocumentsVC, animated: true)
        }

        @IBAction func btnViewCaseSummaryTapped(_ sender: UIButton) {
            let vc = RaiseAnIssueViewController.instantiate(appStoryboard: .support) as! RaiseAnIssueViewController
            vc.notes = viewModel.getNotes()
            self.navigationController?.pushViewController(vc, animated: true)
        }

        @IBAction func btnViewLastPrescriptionTapped(_ sender: UIButton) {
        }

        @IBAction func btnViewLastReportTapped(_ sender: UIButton) {
        }

        @IBAction func btnViewPast4PrescriptionTapped(_ sender: UIButton) {
            let vc: MaxRecordVC = MaxRecordVC.instantiate(appStoryboard: .dashboard)
            self.navigationController?.pushViewController(vc, animated: true)
        }

        @IBAction func btnWriteAndUploadPrescriptionTapped(_ sender: UIButton) {
           showCustomPopup()
        }

        @IBAction func btnNoShowTapped(_ sender: UIButton) {
            let noShowPatientPopUpVC: NoShowPatientPopUpVC = NoShowPatientPopUpVC.instantiate(appStoryboard: .dashboard)
            noShowPatientPopUpVC.modalTransitionStyle = .crossDissolve
            noShowPatientPopUpVC.modalPresentationStyle = .overCurrentContext
            noShowPatientPopUpVC.completion = { value in
                if value {
                    self.viewModel.getAppointment {
                    self.btnnoShow.isHidden.toggle()
                    }
                }
            }
            self.present(noShowPatientPopUpVC, animated: true, completion: nil)
        }

        @IBAction func btnRescheduleTapped(_ sender: UIButton) {
            let rescheduleAppointmentPopUpVC: RescheduleAppointmentPopUpVC = RescheduleAppointmentPopUpVC.instantiate(appStoryboard: .dashboard)
            rescheduleAppointmentPopUpVC.modalTransitionStyle = .crossDissolve
            rescheduleAppointmentPopUpVC.modalPresentationStyle = .overCurrentContext
            rescheduleAppointmentPopUpVC.id =  (branch_id: viewModel.getBranchID(),procedure_info: viewModel.getProcedureInfo())
            rescheduleAppointmentPopUpVC.completion = { rescheduled in
               if rescheduled {
                   self.viewModel.getAppointment {
                    self.btnnoShow.isHidden = self.viewModel.isnoShowHidden
                   }
                }
            }
            self.present(rescheduleAppointmentPopUpVC, animated: true, completion: nil)
        }

        @IBAction func btnContactSupportTapped(_ sender: UIButton) {
            let uploadedDocumentsVC: ContactSupportVC = ContactSupportVC.instantiate(appStoryboard: .support)
            self.navigationController?.pushViewController(uploadedDocumentsVC, animated: true)
        }


        @objc func showCustomPopup() {
            guard let popupViewController = CustomPopupView.instantiate() else { return }
            popupViewController.delegate = self
            popupViewController.titleString = "Choose one option"

            let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(20), popupWidth: self.view.frame.width-20, popupHeight: 237)
            popupVC.cornerRadius = 20
            popupVC.backgroundAlpha = 0.0
            popupVC.backgroundColor = .clear
            popupVC.canTapOutsideToDismiss = true
            popupVC.shadowEnabled = true
            popupVC.delegate = self
            popupVC.modalPresentationStyle = .custom
            self.view.alpha = 0.5
            self.present(popupVC, animated: true, completion: nil)
        }

    }


    extension PateintDetailVC : PopupViewControllerDelegate, CustomPopupViewDelegate
    {
        // MARK: Default Delegate Methods For Dismiss Popup
        public func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController)
        {
            dismiss(animated: true)
            {
                debugPrint("Popup Dismiss")
                self.view.alpha = 1
            }
        }

        // MARK: Custom Delegate Methods For Dismiss Popup on Action
        func customPopupViewExtension(sender: CustomPopupView, didSelectOption: CustomPopupAction)
        {
            dismiss(animated: true)
            {
                switch didSelectOption {
                    case .close:
                    //"Custom Popup Dismiss On Done Button Action"
                    break
                    case .write:
                    //"Write"
                    self.openWriteSomethingVC()
                    self.view.alpha = 1
                    case .upload:
                    //"upload"
                   //present camera and gallery view
                    self.openGalleryAndCameraPopup()
                }
            }
        }
    }

    extension PateintDetailVC  {

        fileprivate func openWriteSomethingVC() {

        }

        fileprivate func openGalleryAndCameraPopup() {
            guard let popupViewController = PickerView.instantiate() else { return }
            popupViewController.delegate = self
            popupViewController.titleString = "Upload Prescription From"
            let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(20), popupWidth: self.view.frame.width-40, popupHeight: 200)
            popupVC.cornerRadius = 20
            popupVC.backgroundAlpha = 0.0
            popupVC.backgroundColor = .clear
            popupVC.canTapOutsideToDismiss = true
            popupVC.shadowEnabled = true
            popupVC.delegate = self
            popupVC.modalPresentationStyle = .custom
            self.present(popupVC, animated: true, completion: nil)
        }

    }

    extension PateintDetailVC: PickerViewDelegate {

        func pickerViewPopupViewExtension(sender: PickerView, didSelectOption : PickerViewAction) {
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                switch didSelectOption {
                    case .camera:
                        self.openCameraPicker()
                    case .gallery:
                         self.openGalleryPicker()
                    case .close:
                       break
                }
                self.view.alpha = 1.0
            }
          }
        }

        func openCameraPicker() {
            let vc = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
            }else{
            vc.sourceType = .savedPhotosAlbum
            }
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        }

        func openGalleryPicker() {
            let imagePicker = ImagePickerController()
                    imagePicker.settings.selection.max = 1
                    imagePicker.settings.selection.unselectOnReachingMax = true
                    imagePicker.settings.fetch.assets.supportedMediaTypes = [.image, .video]
                    imagePicker.albumButton.tintColor = UIColor.green
                    imagePicker.cancelButton.tintColor = UIColor.red
                    imagePicker.doneButton.tintColor = UIColor.purple
                    imagePicker.navigationBar.barTintColor = .black
                    imagePicker.settings.theme.backgroundColor = .black
                    imagePicker.settings.theme.selectionFillColor = UIColor.gray
                    imagePicker.settings.theme.selectionStrokeColor = UIColor.yellow
                    imagePicker.settings.theme.selectionShadowColor = UIColor.red
                    imagePicker.settings.theme.previewTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]
                    imagePicker.settings.theme.previewSubtitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor: UIColor.white]
                    imagePicker.settings.theme.albumTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor: UIColor.white]
                    imagePicker.settings.list.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
                        switch (verticalSize, horizontalSize) {
                        case (.compact, .regular): // iPhone5-6 portrait
                            return 2
                        case (.compact, .compact): // iPhone5-6 landscape
                            return 2
                        case (.regular, .regular): // iPad portrait/landscape
                            return 3
                        default:
                            return 2
                        }
                    }

                    self.presentImagePicker(imagePicker, select: { (asset) in
                        print("Selected: \(asset)")
                    }, deselect: { (asset) in
                        print("Deselected: \(asset)")
                    }, cancel: { (assets) in
                        print("Canceled with selections: \(assets)")
                    }, finish: { (assets) in
                        print("Finished with selections: \(assets)")

                        print(type(of: assets))

                        var data = [Data]()
                        var files = [AttachmentInfo]()

                        //Change assets to data
                        for (index,asset) in assets.enumerated() {
                        let fileName = "File\(index)"
                        data.append(asset.pngData!)
                            files.append(AttachmentInfo(withImage: UIImage(data: asset.pngData!)!, imageName: fileName, apiKey: ""))
                        }
                        print("data",data)



                      //  UploadPrescriptionPopupView
                        DispatchQueue.main.async {
                         self.openUploadPrescriptionPopup(dataArray: data,files: files)
                        }
//
                    })
        }
    }


    extension PateintDetailVC {

        fileprivate func openUploadPrescriptionPopup(dataArray: [Data],files: [AttachmentInfo]) {
            guard let popupViewController = UploadPrescriptionPopupView.instantiate() else { return }
            popupViewController.delegate = self
            popupViewController.files = files
            popupViewController.titleString = "Prescription Detail"
            popupViewController.dataArray = dataArray
            let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(20), popupWidth: self.view.frame.width-20, popupHeight: 203)
            popupVC.cornerRadius = 20
            popupVC.backgroundAlpha = 0.0
            popupVC.backgroundColor = .clear
            popupVC.canTapOutsideToDismiss = true
            popupVC.shadowEnabled = true
            popupVC.delegate = self
            self.view.alpha = 0.5
            popupVC.modalPresentationStyle = .custom
            self.present(popupVC, animated: true, completion: nil)
        }
    }

extension PateintDetailVC : UploadPrescriptionPopupViewDelegate{



        func pickerViewPopupViewExtension(sender: UploadPrescriptionPopupView, didSelectOption: UploadPrescriptionPopupViewAction, data: [Data]?, files: [AttachmentInfo]?) {
            self.dismiss(animated: true) {
                switch didSelectOption {
                    case .upload:
                    //upload image and show progress hud
                        self.openPrescriptionLoaderView(dataArray: data, files: files)
                        break
                    case .add:
                        self.view.alpha = 1
                        break
                    case .close:
                        self.view.alpha = 1
                        break
                }

            }
        }

    }

    extension PateintDetailVC:PrescriptionLoaderViewDelegate,PrescriptionUploadedViewDelegate {

        fileprivate func openPrescriptionLoaderView(dataArray: [Data]?,files: [AttachmentInfo]?){
           guard let popupViewController = PrescriptionLoaderView.instantiate() else { return }
            popupViewController.delegate = self
            popupViewController.files = files!
            popupViewController.dataArray = dataArray!
            //popupViewController.titleString = "Prescription Detail"
             let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(20), popupWidth: self.view.frame.width-20, popupHeight: 203)
            popupVC.cornerRadius = 20
            popupVC.backgroundAlpha = 0.0
            popupVC.backgroundColor = .clear
            popupVC.canTapOutsideToDismiss = false
            popupVC.shadowEnabled = true
            popupVC.delegate = self
            self.view.alpha = 0.5
            popupVC.modalPresentationStyle = .custom
            self.present(popupVC, animated: true, completion: nil)
        }

        func completedDownload() {
            self.dismiss(animated: true) {
                self.openUploadFinishedView()
            }
        }

        func openUploadFinishedView(){
            guard let popupViewController = PrescriptionUploadedView.instantiate() else { return }
            popupViewController.delegate = self
             popupViewController.titleString = "Prescription Uploaded"
              let popupVC = PopupViewController(contentController: popupViewController, position: .bottom(20), popupWidth: self.view.frame.width-20, popupHeight: 203)
             popupVC.cornerRadius = 20
             popupVC.backgroundAlpha = 0.0
             popupVC.backgroundColor = .clear
             popupVC.canTapOutsideToDismiss = false
             popupVC.shadowEnabled = true
             popupVC.delegate = self
             self.view.alpha = 0.5
             popupVC.modalPresentationStyle = .custom
             self.present(popupVC, animated: true, completion: nil)
        }

        func uploadFinished() {
            view.alpha = 1.0
            dismiss(animated: true)
        }

    }




    //MARK:- For Camera
    extension PateintDetailVC :  UINavigationControllerDelegate,UIImagePickerControllerDelegate {

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)

            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            var dataArray = [Data]()
            dataArray.append(image.jpegData(compressionQuality: 0.5) ?? Data())
            print(dataArray)
            var files = [AttachmentInfo]()
            let fileName = "File"
            files.append(AttachmentInfo(withImage: image, imageName: fileName, apiKey: ""))
            openUploadPrescriptionPopup(dataArray: dataArray, files: files)

            


            // print out the image size as a test
            print(image.size)

        }
    }
