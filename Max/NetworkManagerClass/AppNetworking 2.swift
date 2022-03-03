//
//  AppNetworking.swift
//  FutureNow
//
//  Created by MacMini-iOS on 18/07/19.
//  Copyright © 2019 Quytech. All rights reserved.
//


import Foundation
import SwiftyJSON
import Alamofire
import Photos
import ObjectMapper
import JGProgressHUD

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (String) -> ()
typealias Completion = (Response) -> ()

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (NSError) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
typealias DownloadData = (_ data : Data) -> ()
typealias UploadFileParameter = (fileName: String, key: String, data: Data, mimeType: String)

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
    static let username = "admin"
    static let password = "12345"

    static func POST(endPoint : String,
                     parameters : JSONDictionary = [:],
                     parameterArray: JSONDictionaryArray = [],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     completion : @escaping Completion) {
        
        
        request(URLString: endPoint, httpMethod: .post, parameters: parameters, parameterArray: parameterArray, headers: headers, loader: loader, completion: completion)
    }
    
    
    static func GET(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    completion : @escaping Completion) {
        
        request(URLString: endPoint, httpMethod: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers, loader: loader, completion: completion)
    }
    
    static func UPLOAD(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    files: [AttachmentInfo],
                    loader : Bool = true,
                    httpMethod: HTTPMethod = .post,
                    completion : @escaping Completion) {
        uploadRequest(URLString: endPoint, httpMethod: httpMethod, parameters: parameters, files: files, loader: loader, completion: completion)
    }

    static func PUT(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    completion : @escaping Completion) {
        
        request(URLString: endPoint, httpMethod: .put, parameters: parameters, headers: headers, loader: loader, completion: completion)
    }
    
    static func PATCH(endPoint : String,
                      parameters : JSONDictionary = [:],
                      encoding: URLEncoding = URLEncoding.httpBody,
                      headers : HTTPHeaders = [:],
                      loader : Bool = true,
                      completion : @escaping Completion) {
        
        request(URLString: endPoint, httpMethod: .patch, parameters: parameters, encoding: encoding, headers: headers, loader: loader, completion: completion)
    }
    
    static func DELETE(endPoint : String,
                       parameters : JSONDictionary = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       completion : @escaping Completion) {
        
        request(URLString: endPoint, httpMethod: .delete, parameters: parameters, headers: headers, loader: loader, completion: completion)
    }
    
    
    private static func request(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                parameterArray: JSONDictionaryArray = [],
                                encoding: ParameterEncoding = JSONEncoding.default,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                completion : @escaping Completion) {
        
        if loader {
            DispatchQueue.main.async {
                JGProgress.instance.showActivity()
            }
        }
        
        makeRequest(URLString: URLString, httpMethod: httpMethod, parameters: parameters, parameterArray: parameterArray, encoding: encoding, headers: headers, loader: loader, success: { (data) in
            if loader {
                DispatchQueue.main.async {
                    JGProgress.instance.hideActivity()
                }
            }
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            
            let json = JSON(response)
        
            let responseType = Validate.link(code: json[APIConstants.code].stringValue)
            
            switch responseType {
            case .success:
                return completion(Response.success(response))
                
            case .failure:
                completion(Response.failure(json[APIConstants.message].stringValue))
                
            case .notVerified:
                completion(Response.notVerified(response))
                
            case .invalidAccessToken:
                self.tokenExpired()
                
            default :
                break
            }
        }, failure: { message in
            if loader {
                DispatchQueue.main.async {
                    JGProgress.instance.hideActivity()
                }
            }
            completion(Response.failure(message))
        })
    }
    
    
    private static func uploadRequest(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                files: [AttachmentInfo],
                                encoding: ParameterEncoding = JSONEncoding.default,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                completion : @escaping Completion) {
        
        if loader {
            DispatchQueue.main.async {
                JGProgress.instance.showActivity()
            }
        }
        
        upload(URLString: URLString, httpMethod: httpMethod, parameters: parameters, files: files, success: { (data) in
            if loader { JGProgress.instance.hideActivity() }
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            
            let json = JSON(response)

            
            let responseType = Validate.link(code: json[APIConstants.code].stringValue)

            switch responseType {
            case .success:
                return completion(Response.success(response))
                
            case .failure:
                completion(Response.failure(json[APIConstants.message].stringValue))
                
            case .notVerified:
                completion(Response.notVerified(response))
                break
            case .invalidAccessToken:
                self.tokenExpired()
                break
            default : break
            }
            
        }, failure: { message in
            if loader { JGProgress.instance.hideActivity() }
            completion(Response.failure(message))
        })
        
    }
        
    private static func adminBlocked() {
        
    }
    
    private static func makeRequest(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                parameterArray: JSONDictionaryArray = [],
                                encoding: ParameterEncoding = JSONEncoding.default,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                success : @escaping HttpClientSuccess ,
                                failure : @escaping HttpClientFailure) {
        
        var header : [String: String] = [:]
        let accessToken = UserDefaults.standard.value(forKey: "auth_token") as? String
        if !(accessToken ?? "").isEmpty {
            header["Authorization"] = "\(accessToken ?? "")"
            header["Content-Type"] = "application/json"
        } else {
            header = headers
        }
        
//        Debug.log("===== HEADERS ====")
//        Debug.log("\(header)")
//        Debug.log("==== METHOD ====")
//        Debug.log("\(httpMethod)")
//        Debug.log("==== URL STRING ====")
//        Debug.log(URLString)
//        Debug.log("==== PARAMETERS ====")
//        Debug.log(parameters.description)
        
        let updatedHeaders : HTTPHeaders = header
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120

        if !parameterArray.isEmpty {
            var request: URLRequest
            guard let url = URL(string: URLString) else {
                if loader { JGProgress.instance.hideActivity() }
                return
            }
            
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = header
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameterArray, options: .prettyPrinted)
            
            Alamofire.request(request).responseJSON{ (response) in
                if loader { JGProgress.instance.hideActivity() }
                                
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
//                    Debug.log("==== RESPONSE ====")
//                    Debug.log("\(json)")
                    
                    success(data)
                case .failure(let error):
//                    Debug.log("===== FAILURE ====")
//                    Debug.log(error.localizedDescription)
                    
//                    Debug.log("==== RESPONSE ====")
//                    Debug.log(String(data: response.data!, encoding: .utf8) ?? "")
                    
                    if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                        
                        failure("Your Internet connection is not active at this time.")
                    } else {
                        failure(error.localizedDescription)
                    }
                }
            }
        }else {
            manager.request(URLString, method: httpMethod, parameters: parameters, encoding: encoding, headers: updatedHeaders).responseJSON { (response:DataResponse<Any>) in
                
                if loader { JGProgress.instance.hideActivity() }
                
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
//                    Debug.log("==== RESPONSE ====")
//                    Debug.log("\(json)")
                    
                    success(data)
                case .failure(let error):
//                    Debug.log("===== FAILURE ====")
//                    Debug.log(error.localizedDescription)
                    
//                    Debug.log("==== RESPONSE ====")
//                    Debug.log(String(data: response.data!, encoding: .utf8) ?? "")
                    
                    if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                        
                        failure("Your Internet connection is not active at this time.")
                    } else {
                        failure(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private static func upload(URLString : String,
                               httpMethod : HTTPMethod,
                               parameters : JSONDictionary = [:],
                               files : [AttachmentInfo] = [],
                               headers : HTTPHeaders = [:],
                               loader : Bool = true,
                               success : @escaping HttpClientSuccess ,
                               failure : @escaping HttpClientFailure) {
        
        var header : [String: String] = [:]
        let accessToken = UserDefaults.standard.value(forKey: "auth_token") as? String
        if !(accessToken ?? "").isEmpty {
            header["Authorization"] = "\(accessToken ?? "")"
        } else {
            header = headers
        }
        
        guard let url = try? URLRequest(url: URLString, method: httpMethod, headers: header) else { return }
        
        if loader {
            DispatchQueue.main.async {
                JGProgress.instance.showActivity()
            }
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            
//            Debug.log("==== METHOD ====")

            files.forEach({ (file) in
                if let data = file.data {
//                    Debug.log("\(file.data?.debugDescription ?? "") \(file.fileName), \(file.mimeType) \(file.apiKey)")
                    multipartFormData.append(data, withName: file.apiKey, fileName: file.fileName, mimeType: file.mimeType )
                }
            })
            
            parameters.forEach({ (paramObject) in
                
                if let arr = paramObject.value as? Array<AnyObject> {
                    
                    for (index, item) in arr.enumerated() {
                        if let data = ("\(item)" as AnyObject).data(using : String.Encoding.utf8.rawValue) {
                            multipartFormData.append(data, withName: "\(paramObject.key)[\(index)]")
//                            Debug.log("Value::::----\((item as AnyObject))   and value ::::---- \(paramObject.key)[\(index)]")
                        }
                    }
                } else if let dict = paramObject.value as? [String: Any] {
                    dict.forEach({ (dictObject) in
                        
                        if let arr = dictObject.value as? Array<AnyObject> {
                            
                            for (index, item) in arr.enumerated() {
                                if let data = ("\(item)" as AnyObject).data(using : String.Encoding.utf8.rawValue) {
                                    multipartFormData.append(data, withName: "\(dictObject.key)[\(index)]")
//                                    Debug.log("Value::::----\((item as AnyObject))   and value ::::---- \(dictObject.key)[\(index)]")
                                }
                            }
                        } else {
                            if let data = ("\(dictObject.value)" as AnyObject).data(using : String.Encoding.utf8.rawValue) {
                                multipartFormData.append(data, withName: dictObject.key)
//                                Debug.log("Value::::----\((paramObject.value as AnyObject))   and value ::::---- \(dictObject.key)")
                                
                            }
                        }
                    })
                } else {
                    if let data = ("\(paramObject.value)" as AnyObject).data(using : String.Encoding.utf8.rawValue) {
                        multipartFormData.append(data, withName: paramObject.key)
//                        Debug.log("Value::::----\((paramObject.value as AnyObject))   and value ::::---- \(paramObject.key)")
                        
                    }
                }
            })

        }, with: url, encodingCompletion: { encodingResult in
            
            switch encodingResult{
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    
                    if loader { JGProgress.instance.hideActivity() }

//                    Debug.log("==== METHOD ====")
//                    Debug.log("\(httpMethod)")
//                    Debug.log("==== URL STRING ====")
//                    Debug.log(URLString)
//                    Debug.log("==== HEADERS ====")
//                    Debug.log("\(header)")
//                    Debug.log("==== PARAMETERS ====")
//                    Debug.log("\(parameters)")
                    
                    switch response.result {
                    case .success(let value):
//                        Debug.log("==== RESPONSE ====")
//                        Debug.log("\(JSON(value))")
                        success(value)
                        
                    case .failure(let error):
                        
//                        Debug.log("===== FAILURE ====")
//                        Debug.log(error.localizedDescription)
//
//                        Debug.log("==== RESPONSE ====")
//                        Debug.log(String(data: response.data!, encoding: .utf8) ?? "")
                        
                        if loader { JGProgress.instance.hideActivity() }
                        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                            
                            failure("Your Internet connection is not active at this time.")
                        } else {
                            failure(error.localizedDescription)
                        }
                    }
                })
                
            case .failure(let error):
                if loader { JGProgress.instance.hideActivity() }
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    failure("Your Internet connection is not active at this time.")
                } else {
                    failure(error.localizedDescription)
                }
            }
        })
    }
    
    
    //MARK: - Token Expired
    private static func tokenExpired() {
//        Alerts.shared.show(alert: .warning, message: "Your session has expired; please login again.", type: .info)
//        NavigationManager.shared.logout()
    }
    
}


class ProgressHud: UIViewController {
    
    static let shared = ProgressHud()
    
//    /// Show Activity Loader
//    func showActivityLoader() {
//
//    }
//
//    /// Hide Activity Loader
//    func hideActivityLoader() {
//    }
}

public struct AttachmentInfo {
    
    public var fileName: String
    public var apiKey : String
    public var mimeType: String
    public var extens_string: String = ""
    public var url: URL? = nil
    public var data: Data? = nil
    
    
    public init() {
        url = nil
        data = nil
        fileName = ""
        mimeType = ""
        apiKey = "profile_image"
        extens_string = ""
    }
    
    public init(withImage image: UIImage, imageName: String, apiKey: String) {
        self.fileName = imageName
        self.apiKey = apiKey
        self.mimeType = fileName.mimeType()
        if let imageData = returnRepresentationUnder1MB(image: image) {
            self.data = imageData
        }
        self.fileName = imageName + "." + (self.extens_string.count > 0 ? self.extens_string : "jpg")
    }
    
    func returnRepresentationUnder1MB(image: UIImage) -> Data? {
        let oneMB = 1024 * 1024
        var finalData: Data?
        if let data = image.jpegData(compressionQuality: 0.4)  { // UIImageJPEGRepresentation(image, 1){
            let ratio = CGFloat(oneMB)/CGFloat(data.count)
            finalData = image.jpegData(compressionQuality: ratio)
        }
        if finalData == nil {
//            Debug.log("Image compression failed.")
        }
        return finalData
    }
    
}

