//
//  Webservice+EndPoints.swift
//  FutureNow
//
//  Created by MacMini-iOS on 18/07/19.
//  Copyright © 2019 Quytech. All rights reserved.
//

extension WebServices {

    static var baseUrl: String {

        return "https://medi.hlthclub.in/vault/v1/"

        //development url
        // return "https://betamedi.hlthclub.in/dev/"

        //uat url
        //return "https://betamedi.hlthclub.in/uat/"

        //live url
        //return "https://betamedi.hlthclub.in/prod/"
    }
     enum EndPoint : String {
        
        //Web services end point
         case doctor_slot_config_id = "slots/doctor-slot-config/"
         case practiceUpdate = "slots/practice-update"
         case logins = "logins/attempt/otp"
         case verify_otp = "logins/verify/otp"
         case appointments = "appointments?"
         case getProfileData = "doctor/get-my-profile"
         case getAppData = "applications"
         case getDoctor = "doctor"
         case branches = "branches"
         case departments = "departments"
         case nationality = "master/nationality"
         case procedure = "master/procedure"
         case addAppointments = "appointments"
         case ipdPatient = "appointments/ipd?"
         case prescription = "prescription?"
         case pathDoc = "prescription/path?"
         case slots = "slots/avail-slots?"
         case getPatientByMobile = "patients/get-patients-by-mobile/"
         case gender = "master/gender"
         case addPatient = "patients"
         case uploadFile = "fileuploads/path"
         case document = "patients/document?"
         case getAppointments = "appointments/"
         case appointmentStatus = "appointments/status/c631f70a-a346-4713-97a8-f3e393f7d531"
         case rescheduleStatus = "appointments/status/0c6f30c3-f629-46b4-ba51-08b578031ae0"

        var path : String {
            let url = baseUrl
            return url + self.rawValue
        }
    }
}

enum Response {
    case notVerified(Any?)
    case success(Any?)
    case failure(String?)
}

internal struct APIConstants {
    
//    static let code = "code"
    static let code = "statusCode"
    static let success = "success"
    static let message = "message"
    
}

enum Validate : String {
    case none
    case success = "200"
    case failure = "400"
    case invalidAccessToken = "204"//"207"
    case adminBlocked = "402"
    case notVerified = "3"
    
    static func link(code: String) -> Validate {
        switch code {
        case "200", "220", "222", "221":
            return .success
//        case "240", "207", "209":
//             return .invalidAccessToken
        case "204":
             return .invalidAccessToken
        default:
             return .failure
        }
    }
}

