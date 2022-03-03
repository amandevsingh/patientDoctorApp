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

// MARK:- User Management APIs
extension WebServices {
   /*
    static func checkNumber( params: [String: Any], successCompletion: ((ResponseData<CheckNumber>?)-> Void)?) {
        AppNetworking.POST(endPoint: EndPoint.check_mobile_number.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<CheckNumber>>().map(JSONObject:value)
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
    
    static func login( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
        AppNetworking.POST(endPoint: EndPoint.login.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
                if let object = response?.object {
                    AuthManager.shared.userData = object
                    AuthManager.shared.session_id = object.session_id
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
    
    static func verifyOTP( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.registerVerifyOtp.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
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
    
    static func resendOTP( params: [String: Any], successCompletion: ((ResponseData<CheckNumber>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.resendOtp.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<CheckNumber>>().map(JSONObject:value)
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
    
    static func registerUser( params: [String: Any], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.registration.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
                if let object = response?.object {
                    AuthManager.shared.userData = object
                    AuthManager.shared.session_id = object.session_id
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
    
    
    static func registerUserMultipart( params: [String: Any], files:[AttachmentInfo], successCompletion: ((ResponseData<UserModal>?)-> Void)?) {
        AppNetworking.UPLOAD(endPoint: EndPoint.registration.path, parameters:params, files: files) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<UserModal>>().map(JSONObject:value)
                if let object = response?.object {
                    AuthManager.shared.userData = object
                    AuthManager.shared.session_id = object.session_id
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
    
    static func getLanguages( params: [String: Any], successCompletion: ((ResponseData<LanguageModal>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.getLanguages.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<LanguageModal>>().map(JSONObject:value)
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
    
    static func getLanguagesLevel( params: [String: Any], successCompletion: ((ResponseData<LanguageModal>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.getLanguageLevels.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<LanguageModal>>().map(JSONObject:value)
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
    
    static func getStaticPagesData( params: [String: Any], successCompletion: ((ResponseData<GenericContentModal>?)-> Void)?) {
        
        AppNetworking.POST(endPoint: EndPoint.getStaticPages.path, parameters: params, loader: true) {  (response) in
            switch response {
            case .success(let value):
                Debug.log("\(value ?? "")")
                let response = Mapper<ResponseData<GenericContentModal>>().map(JSONObject:value)
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
    
  */
}

//Community services



//Table APIs


//Other APIs



