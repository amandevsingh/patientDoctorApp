//
//  Webservices.swift
//  FutureNow
//
//  Created by MacMini-iOS on 18/07/19.
//  Copyright © 2019 Quytech. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

enum WebServices { }

extension NSError {
    
    convenience init(localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

extension WebServices {
    
    
    
    //doctor/get-my-AppData
        static func getAppData(successCompletion: ((ResponseData<ApplicationTypeModel>?)->Void)?) {
            AppNetworking.GET(endPoint: EndPoint.getAppData.path, loader: true) { (response) in
                switch response {
                    case .success(let value):
                        Debug.log("\(value ?? "")")
                        let response = Mapper<ResponseData<ApplicationTypeModel>>().map(JSONObject: value)
                        successCompletion?(response)
                        break
                    case .notVerified(let value):
                        Debug.log("\(value ?? "")")
                        break
                    case .failure(let message):
                    Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                    break
                }
            }
        }
    
    
    
    //Mark --doctor Profile---
        static func getDoctorProfileData(successCompletion: ((ResponseData<DoctorProfileModel>?)->Void)?) {
            AppNetworking.GET(endPoint: EndPoint.getDoctor.path, loader: true) { (response) in
                switch response {
                    case .success(let value):
                        Debug.log("\(value ?? "")")
                        let response = Mapper<ResponseData<DoctorProfileModel>>().map(JSONObject: value)
                        successCompletion?(response)
                        break
                    case .notVerified(let value):
                        Debug.log("\(value ?? "")")
                        break
                    case .failure(let message):
                    Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                    break
                }
            }
        }

    static func loginWithOTP(params: [String: Any], successCompletion: ((ResponseData<Login>?)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.logins.path, parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<Login>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    static func verifyOtp(params: [String: Any], successCompletion: ((ResponseData<VerifyOtp>?)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.verify_otp.path, parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<VerifyOtp>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    static func getAppointment(params: [String: Any], successCompletion: ((ResponseData<AppointmentDataModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.appointments.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<AppointmentDataModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getOPD(params: [String: Any], successCompletion: ((ResponseData<OPDDataModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.appointments.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<OPDDataModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    
    static func getDoctorslotConfig(doctor_slot_config_id: String, successCompletion: ((ResponseData<DoctorSlotConfigModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.doctor_slot_config_id.path + doctor_slot_config_id)", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<DoctorSlotConfigModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    
    static func getPracticeUpdate(params: [String: Any], successCompletion: ((Bool)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.practiceUpdate.path, parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
//  let response = Mapper<ResponseData<DoctorSlotConfigModel>>().map(JSONObject: value)
                successCompletion?(true)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getBranchList(successCompletion: ((ResponseData<Branch>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.branches.path, parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<Branch>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getAvailableSlots(params: [String: Any],successCompletion: ((ResponseData<SlotModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.slots.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<SlotModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getPatientsByMobile(params: [String: Any],successCompletion: ((ResponseData<PatientModel>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.getPatientByMobile.path + (params["mobile"]  as? String ?? ""), parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<PatientModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }


//doctor/get-my-profile
    static func getProfileData(successCompletion: ((ResponseData<UserProfileModel>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.getProfileData.path, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<UserProfileModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getDepartment(params: [String:Any],successCompletion: ((ResponseData<DepartmentModel>?)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.departments.path, parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<DepartmentModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func addPatient(params: [String:Any],successCompletion: ((ResponseData<PatientModel>?)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.addPatient.path, parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<PatientModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getNationality(successCompletion: ((ResponseData<NationalityModel>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.nationality.path, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<NationalityModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func getProcedures(successCompletion: ((ResponseData<ProcedureItem>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.procedure.path, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<ProcedureItem>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func addAppointment(params: [String:Any],successCompletion: ((ResponseData<AddAppointmentModel>?)->Void)?) {
        AppNetworking.POST(endPoint: EndPoint.addAppointments.path,parameters: params, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<AddAppointmentModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    
    static func getIpdPatientt(params: [String: Any], successCompletion: ((ResponseData<IpdData>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.ipdPatient.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<IpdData>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    static func getPrescription(params: [String: Any], successCompletion: ((ResponseData<PrescriptionModel>?)->Void)?) {
    AppNetworking.GET(endPoint: "\(EndPoint.prescription.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
        switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
    let response = Mapper<ResponseData<PrescriptionModel>>().map(JSONObject: value)
            successCompletion?(response)
            break
        case .notVerified(let value):
            Debug.log("\(value ?? "")")
            break
        case .failure(let message):
        Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
        break
    }
   }
 }

    static func getUploadedPrescription(params: [String: Any], successCompletion: ((ResponseData<UploadedPriscriptionModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.prescription.path + params.changeToString())", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<UploadedPriscriptionModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
      }
    
    
    static func getDocData(params: String, successCompletion: ((ResponseData<UploadedDocModel>?)->Void)?) {
        AppNetworking.GET(endPoint: "\(EndPoint.pathDoc.path + params)", parameters: [String: Any](), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<UploadedDocModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
//    
//    static func getGenderList(successCompletion: ((ResponseData<GenderListDataModel>?)->Void)?) {
//        AppNetworking.GET(endPoint: "\(EndPoint.masterGender.path)", parameters: [String: Any](), loader: true) { (response) in
//            switch response {
//                case .success(let value):
//                    Debug.log("\(value ?? "")")
//                    let response = Mapper<ResponseData<GenderListDataModel>>().map(JSONObject: value)
//                    successCompletion?(response)
//                    break
//                case .notVerified(let value):
//                    Debug.log("\(value ?? "")")
//                    break
//                case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }

    static func getGender(successCompletion: ((ResponseData<Gender>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.gender.path, loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<Gender>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func uploadFile(params: [String:Any],successCompletion: ((ResponseData<UploadFile>?)->Void)?) {
            AppNetworking.POST(endPoint: EndPoint.uploadFile.path,parameters: params, loader: true) {  (response) in
                switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<UploadFile>>().map(JSONObject:value)
                    if let object = response?.object {
//                        AuthManager.shared.userData = object
//                        AuthManager.shared.session_id = object.session_id
                    }
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):

                    Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                    break
                }
            }
        }

    static func getDocument(params:[String: Any],successCompletion: ((ResponseData<Gender>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.document.path + params.changeToString(), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<Gender>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }
    
    static func uploadFileFinal(url: String,params: [String:Any],files: [AttachmentInfo],successCompletion: ((ResponseData<UploadFile>?)->Void)?) {
            AppNetworking.UPLOAD(endPoint: url, files: files){  (response) in
                switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<UploadFile>>().map(JSONObject:value)
//                    if let object = response?.object {
//                        AuthManager.shared.userData = object
//                        AuthManager.shared.session_id = object.session_id
//                    }
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):

                    Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                    break
                }
            }
        }
    
    
    func uploadd(data: Data, urlString: String, mimeType: String, completion: @escaping (Bool, Error?) -> Void) {
        let urlReq = URL(string: urlString)!
        
        var request: URLRequest = URLRequest(url: urlReq)
               request.httpMethod = "PUT"
               request.httpBody = data
               request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        let tasksession: URLSessionDataTask = URLSession.shared.dataTask(with: request, completionHandler: { (response, urlResp, error) in
                   if let data: Data = response {
                       do {
                           let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                           debugPrint("json \(json)")
                       }
                       catch {
                           debugPrint("error \(error)")
                       }
                   }



                   print(response ?? "response nil")
                   print(error ?? "response nil")
               })
               tasksession.resume()
    }

    static func getAppointments(params:[String: Any],successCompletion: ((ResponseData<PatientDetailAppointmentModel>?)->Void)?) {
        AppNetworking.GET(endPoint: EndPoint.getAppointments.path.appending("\(params.first?.value ?? "")"), loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<PatientDetailAppointmentModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func toggleAppointmentStatus(params:[String: Any],successCompletion: ((ResponseData<PatientDetailAppointmentModel>?)->Void)?) {
        AppNetworking.PATCH(endPoint: EndPoint.appointmentStatus.path, parameters:params,loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<PatientDetailAppointmentModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }

    static func rescheduleAppointment(params:[String: Any],successCompletion: ((ResponseData<PatientDetailAppointmentModel>?)->Void)?) {
        AppNetworking.PATCH(endPoint: EndPoint.rescheduleStatus.path, parameters:params,loader: true) { (response) in
            switch response {
                case .success(let value):
                    Debug.log("\(value ?? "")")
                    let response = Mapper<ResponseData<PatientDetailAppointmentModel>>().map(JSONObject: value)
                    successCompletion?(response)
                    break
                case .notVerified(let value):
                    Debug.log("\(value ?? "")")
                    break
                case .failure(let message):
                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
                break
            }
        }
    }


//https://medi.hlthclub.in/vault/v1/appointments/c631f70a-a346-4713-97a8-f3e393f7d531
}









//// MARK:- User Management APIs
//extension WebServices {
//
//    static func checkNumber( params: [String: Any], successCompletion: ((ResponseData<CheckNumber>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.check_mobile_number.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CheckNumber>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func login( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.login.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
//                if let object = response?.object {
//                    AuthManager.shared.userData = object
//                    AuthManager.shared.session_id = object.session_id
//                }
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func verifyOTP( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.registerVerifyOtp.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func resendOTP( params: [String: Any], successCompletion: ((ResponseData<CheckNumber>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.resendOtp.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CheckNumber>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func registerUser( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.registration.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
//                if let object = response?.object {
//                    AuthManager.shared.userData = object
//                    AuthManager.shared.session_id = object.session_id
//                }
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func registerUserMultipart( params: [String: Any], files:[AttachmentInfo], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
//        AppNetworking.UPLOAD(endPoint: EndPoint.registration.path, parameters:params, files: files) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
//                if let object = response?.object {
//                    AuthManager.shared.userData = object
//                    AuthManager.shared.session_id = object.session_id
//                }
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getLanguages( params: [String: Any], successCompletion: ((ResponseData<LanguageModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getLanguages.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<LanguageModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getLanguagesLevel( params: [String: Any], successCompletion: ((ResponseData<LanguageModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getLanguageLevels.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<LanguageModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getStaticPagesData( params: [String: Any], successCompletion: ((ResponseData<GenericContentModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getStaticPages.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<GenericContentModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//}
//
////Community services
//
//extension WebServices {
//
//
//    static func getCategoryList( params: [String: Any], successCompletion: ((ResponseData<CategoryModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getEventList.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CategoryModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func getCommunityAndGroup( params: [String: Any], successCompletion: ((ResponseData<CommunityModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getCommunityList.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CommunityModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getCommunityDetail( params: [String: Any], successCompletion: ((ResponseData<SubscribeModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getCommunityDetails.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<SubscribeModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getCommunitySubscribe( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.subscribeCommunity.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    //subscribeGroup
//    static func getSubscribeGroup( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.subscribeGroup.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func unsubscribeCommunity( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.unSubscribeCommunity.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//    //unSubscribeGroup
//    static func unsubscribeGroup( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.unSubscribeGroup.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func verifyOTPForCommunitySubscription( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.verifySubscribeCommunityOtp.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//    //verifySubscribeGroupOtp
//    static func verifyOTPForGroupSubscription( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.verifySubscribeGroupOtp.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func resendOTPForGroupSubscription( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.resendOtpForSubscribeGroup.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func resendOTPForCommunitySubscription( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.resendOtpForSubscribeCommunity.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func forgotPass( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.forgotPassword.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func resetAndChangePass( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.updatePassword.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func updateAppLanguage( params: [String: Any], loader: Bool = true, successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.updateAppLanguage.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    //LOGOUT API
//    static func logoutUSer( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.signOut.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func updateSession( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.updateSession.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func deleteAccount( params: [String: Any], successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.deleteAccount.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
////Coins wallet APIs
//
//extension WebServices {
//
//    static func getCoinSlabs( params: [String: Any], successCompletion: ((ResponseData<CoinSlabModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getCoinSlabList.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CoinSlabModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getAvailableCoin( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getMyAvailableCoins.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func purchaseCoin( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<Initial>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.purchaseCoins.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<Initial>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//}
//
////Table APIs
//
//extension WebServices {
//
//  //getBroadCastNotificationDetail
//    static func getBroadCastNotificationDetail( params: [String: Any],loader: Bool,successCompletion: ((ResponseData<BroadCastNotificationDetail>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getBroadCastNotificationDetail.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<BroadCastNotificationDetail>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getTableList( params: [String: Any],loader: Bool,successCompletion: ((ResponseData<TableResponse>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getTablesList.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableResponse>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getTableDetail( params: [String: Any], successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getTableByID.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getTopicDetail( params: [String: Any], successCompletion: ((ResponseData<TopicModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getTopicDetails.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TopicModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getMyBooking( params: [String: Any],loader: Bool,successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getMyBookings.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func checkBookingCode( params: [String: Any], successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.checkTheCode.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//}
//
////Other APIs
//
//extension WebServices {
//    static func getNotificationList( params: [String: Any],loader: Bool, successCompletion: ((ResponseData<NotificationModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getNotificationList.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<NotificationModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getSpecialNotificationList( params: [String: Any],loader: Bool, successCompletion: ((ResponseData<NotificationModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.getSidebarNotificationList.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<NotificationModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func deleteNotification( params: [String: Any], successCompletion: ((ResponseData<NotificationModal>?)-> Void)?) {
//
//        AppNetworking.POST(endPoint: EndPoint.deleteNotification.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<NotificationModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
//// MARK: WebServices: Profile Details fetching and updation methods
//extension WebServices {
//    static func getProfileDetails( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getLocoProfileDetails.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func editProfileDetails( params: [String: Any], successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.editLocoProfile.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func editProfile( params: [String: Any], files:[AttachmentInfo], successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.UPLOAD(endPoint: EndPoint.editLocoProfile.path, parameters:params, files: files) {  (response) in
//            print("===========================")
//            debugPrint(params)
//            print("===========================")
//            switch response {
//
//            case .success(let value):
//
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//
//    }
//
//    static func hideShowAgeGenderBubble( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.userAgeHide.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getSurveyQuestion( params: [String: Any], successCompletion: ((ResponseData<SurveyModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getSurveyQuestions.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<SurveyModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func saveSurveyQuestion( params: [String: Any], successCompletion: ((ResponseData<SurveyModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.saveSurveyQuestions.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<SurveyModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//}
//
//
//extension WebServices {
//
//    static func getUserInvitedList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<InviteModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getInvitedUserList.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<InviteModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getStrangerList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getStrangersList.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getFavouriteList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getUserFavoriteslist.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func addToFavouriteList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.addUserToFavoritelist.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func removeFromFavouriteList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.removeUserFromFavoritelist.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func sendInvites( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)? ) {
//        AppNetworking.POST(endPoint: EndPoint.sendInvitation.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func bookTable( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<DataDays>?)-> Void)? ) {
//        //JoinUserModal
//        AppNetworking.POST(endPoint: EndPoint.bookLocoTable.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<DataDays>>(
//                ).map(JSONObject:value)
//                //JoinUserModal
//
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getBlockedList( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getBlockedUserlist.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func unblockUser( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.unBlockUser.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func blockUser( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.blockUser.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func tableFeedback( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.enteringTheCode.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
//
//extension WebServices {
//
//    static func getCategoryData( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<CategoryModel>?)-> Void)?) {
//           AppNetworking.POST(endPoint: EndPoint.getBringLocoInMyCityCategoey.path, parameters: params, loader: loader) {  (response) in
//               switch response {
//               case .success(let value):
//                   Debug.log("\(value ?? "")")
//                   let response = Mapper<ResponseData<CategoryModel>>().map(JSONObject:value)
//                   successCompletion?(response)
//                   break
//               case .notVerified(let value):
//                   Debug.log("\(value ?? "")")
//                   break
//               case .failure(let message):
//                   Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                   break
//               }
//           }
//
//       }
//
//    static func sendOtpOwnLocoApp( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<OTPModel>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.sendOtpOwnLocoApp.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<OTPModel>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func verifyOtpOwnLocoApp( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<CategoryModel>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.verifyOtpOwnLocoApp.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<CategoryModel>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//
//    static func sendBringLocoToCityData( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.saveBringLocoInMyCity.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func createYouOwnCommunity( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.createYouOwnCommunity.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getOwnLocoApp( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<ProfileModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getOwnLocoApp.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<ProfileModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func saveNotificationSettings( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<NotificationSettings>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.saveNotificationSetting.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<NotificationSettings>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func getNotificationSettings( params: [String: Any], loader:Bool = false, successCompletion: ((ResponseData<NotificationSettings>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getNotificationSetting.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<NotificationSettings>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//
//    static func appFeeback( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.saveAppFeedback.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
//
//extension WebServices {
//
//    static func createClientSecret( params: [String: Any], successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.createClientSecret.path, parameters: params, loader: true) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//    static func reportUser( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<JoinUserModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.reportUser.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<JoinUserModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
//extension WebServices {
//    //private_group_data
//    static func getPrivateGroupData( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<PrivateGroupData>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.private_group_data.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<PrivateGroupData>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}
//
//extension WebServices {
//    static func getUpcomingEvent( params: [String: Any], loader:Bool = false, successCompletion: ((ResponseData<TableModal>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.getLatestComingEvent.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<TableModal>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//}
////MARK:--------checkedsharedbubble
//extension WebServices {
//    static func checkedsharedbubble( params: [String: Any], loader:Bool = true, successCompletion: ((ResponseData<PrivateData>?)-> Void)?) {
//        AppNetworking.POST(endPoint: EndPoint.checkedsharedbubble.path, parameters: params, loader: loader) {  (response) in
//            switch response {
//            case .success(let value):
//                Debug.log("\(value ?? "")")
//                let response = Mapper<ResponseData<PrivateData>>().map(JSONObject:value)
//                successCompletion?(response)
//                break
//            case .notVerified(let value):
//                Debug.log("\(value ?? "")")
//                break
//            case .failure(let message):
//                Alerts.shared.show(alert: .error, message: message ?? "", type: .error)
//                break
//            }
//        }
//    }
//
//}


