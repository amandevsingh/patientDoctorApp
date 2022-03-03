//
//  AuthManager.swift
//  Max
//
//  Created by Ankit on 25/01/22.
//

import Foundation
import ObjectMapper

enum SingletonKeys: String {
    case accessToken = "accessToken"
    case sessionId = "sessionId"
    case doctorId = "doctorId"
    case userData = "userData"
    case visibleDate = "visibleDate"
    case appTypeId = "appTypeId"
    case accId = "accId"
}

class AuthManager: NSObject {
    static let shared = AuthManager()

    private override init(){}

    var userData: UserProfileModel? {
        get{
            guard let data = UserDefaults.standard.value(forKey: SingletonKeys.userData.rawValue) else{
                let mappedModel = Mapper<UserProfileModel>().map(JSON: [:] )
                return mappedModel
            }
            let mappedModel = Mapper<UserProfileModel>().map(JSON: data as! [String : Any])
            return mappedModel
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value.toJSON(), forKey: SingletonKeys.userData.rawValue)

            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.userData.rawValue)
            }
        }
    }


    var accessToken: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.accessToken.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.accessToken.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.accessToken.rawValue)
            }
        }
    }

    var sessionId: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.sessionId.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.sessionId.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.sessionId.rawValue)
            }
        }
    }

    var doctor_id: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.doctorId.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.doctorId.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.doctorId.rawValue)
            }
        }
    }
    
    var visibleDate: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.visibleDate.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.visibleDate.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.visibleDate.rawValue)
            }
        }
    }
    
    
    
    var appTypeId: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.appTypeId.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.appTypeId.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.appTypeId.rawValue)
            }
        }
    }
    
    var accId: String? {
        get{
            return UserDefaults.standard.value(forKey: SingletonKeys.accId.rawValue) as? String
        }
        set{
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: SingletonKeys.accId.rawValue)
            }else{
                UserDefaults.standard.removeObject(forKey: SingletonKeys.accId.rawValue)
            }
        }
    }


}
