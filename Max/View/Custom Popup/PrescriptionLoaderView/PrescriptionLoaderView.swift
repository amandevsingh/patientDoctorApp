//
//  PrescriptionLoaderView.swift
//  Max
//
//  Created by Ankit on 05/02/22.
//

import UIKit
import Alamofire
import JGProgressHUD
import Foundation
import SwiftyJSON
import Photos
import ObjectMapper
import MapKit
import SwiftUI

protocol PrescriptionLoaderViewDelegate: AnyObject {
 func completedDownload()
}

class PrescriptionLoaderView: UIViewController {

    @IBOutlet weak var downloadIndicatorView: UIView!
    @IBOutlet weak var uploadPrescriptionLabel: UILabel!
    @IBOutlet weak var uploadStatusLoaderLabel: UILabel!

    let shapeLayer = CAShapeLayer()
    var files = [AttachmentInfo]()
    var dataArray = [Data]()
    weak var delegate:PrescriptionLoaderViewDelegate?
//    var viewModel = uplo
    var counter = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadPrescription()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc func timerAction() {
        shapeLayer.strokeEnd = (CGFloat(counter) * 0.1)
        counter += 1
        uploadStatusLoaderLabel.text = "\(counter * 10) %"
        if counter == 10 {
           timer.invalidate()
           self.delegate?.completedDownload()
        }
       }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let trackLayer = CAShapeLayer()

        let center = CGPoint(x: downloadIndicatorView.bounds.midX, y: downloadIndicatorView.bounds.midY)

        let circularPath = UIBezierPath(arcCenter: center, radius: 45, startAngle: -(.pi / 2), endAngle: 2 * .pi, clockwise: true)

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        downloadIndicatorView.layer.addSublayer(trackLayer)

        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.302, green: 0.663, blue: 0.816, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.frame = downloadIndicatorView.bounds
        downloadIndicatorView.layer.addSublayer(shapeLayer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for time being this method is called here api needs to be hit
       // animateCircle()
    }

    static func instantiate() -> PrescriptionLoaderView? {
        return PrescriptionLoaderView(nibName: nil, bundle: nil)
    }

    func animateCircle() {

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false //it will keep stroke there after completion
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){[weak self] in
//        self?.delegate?.completedDownload()
//        }
    }

    

}

extension PrescriptionLoaderView: URLSessionTaskDelegate {

    //var session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress:CGFloat = CGFloat(totalBytesSent) / CGFloat(totalBytesExpectedToSend)
        DispatchQueue.main.async {
          self.shapeLayer.strokeEnd = uploadProgress
        }

    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        timer.invalidate()
        self.delegate?.completedDownload()
    }
}

extension PrescriptionLoaderView {

    func uploadPrescription() {
        var params = [String: Any]()
        params["file_name"] = files.first?.fileName
        params["type"] = "PRESCRIPTION"
        params["content_type"] = "image/jpg"

        print("files.first?.data",files.first?.data)
        WebServices.uploadFile(params: params) { response in
          print(response)
            if let urlString = response?.object?.url {
            self.uploadImageData(data: self.dataArray.first ?? Data(), urlString: urlString, mimeType: "image/jpg") { value, error in
                Debug.log("\(value)")
            }
            }
//            WebServices.uploadFileFinal(params: para ?? "") {   response in
//            }
//            WebServices.uploadFileFinal(params: para ?? "", files: self.files) { _ in
//
//            }
//
//            let params = [
//                "Content-Type":"image%2Fjpg",
//                "X-Amz-Algorithm":"AWS4-HMAC-SHA256",
//                "X-Amz-Credential":"ASIA6KBKYC2SOCHVQ3PH%2F20220207%2Fap-south-1%2Fs3%2Faws4_request",
//                "X-Amz-Date":"20220207T123429Z",
//                "X-Amz-Expires":"150",
//                "X-Amz-Security-Token":"IQoJb3JpZ2luX2VjEJz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCmFwLXNvdXRoLTEiRzBFAiEAuigS20qe1Jf9rO1ZNz8LDO40wCsiRD9eSadhiAXoJLkCIFIb253X%2FUGhsI9k0J0VNEqF4gA54xJKQ8e9tCG7vU8VKoUECNX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQAhoMOTgzNjM3MTY5ODI4IgwtD96exmds0XmNcLMq2QNM8lyCy7bwhcIrN4ucE8qEJZvPmsvsYMlmRGDLxfyGU0wwKn9x0RkgpaJmNwAcQKus9ZEl2qqDIucC1pXQQbsn1%2BYZM6YZX%2F2nF0B4EIBqbZPvZY9KVr%2F503GTGl4U%2B9m0yUpd8rYniO792%2BCjXuS1fSUO3r%2FuvTb0MZpa5O6zKTWfMH2xQIrfKCqpKJzc5VgrG4zeb3ESRRZRi6dhIW8%2B685hPT0KLfK2LL80Bf84BRqWRU5wqPWk6T4dgNfHqy7VWSwfUENy49Ci6Pce9s6%2FqLSKCNRNN7tK6hx3XPZQAB501kLhUc%2Fo3h7wda%2B%2BLAwr88cj3z6Z6PPj92hbu1Jy0LiwRA6ABWpN%2BKq2PnYiMjmwR7RzH4lChBn%2BUCKStYgB4FlK0EBk1d8y8LARx4D3tJ4tAVw1F%2B9Hiv2doBZnyz78BdrX3F2hL4Wir5W1gYpBtACELVTURER97LMfUZ3OcKsdYygPgsIOV0HaaMLtlCDh%2BXFMiSaRhLVXPFenuHg87cxIcHy22Pjw7LjAC0Q%2Fxq2aCBPUp8qFBdqAEZe7wSbW8FYTu8i1BhC84kwLYjq8K8F5J5Tx2elpmGZLGwSSEe0A1ihgZwQiHoSbtKB7h3jZfowT%2Bc8PVDDBjYSQBjqlAT34HRN0erv1LHtPfafGLbdwJmMzJWSerspbFWN4TvRqgm3PlJbQo7Ep6xEWPE4WqGf%2FdEiKFSLnuhUzkr5ZPZ2ruw139I1sv6hf%2BAznpf24gi0mtxxNA8Kg9FGbb3Y7TEA1k8Z3gJNk0Sj6FnJdNrGzMe7Fs7D6gPs4g17YrgUkjMez8htxNV%2Fe3UUFIFbtT8QNl%2FcBtpLD7yvvqz3Fgw9yKN%2FDZg%3D%3D",
//                "X-Amz-Signature":"9672ec4b92dba8f6256925e25a14c7e003dc755c0b6d69401d6e6fa4bbcb10b8",
//                "X-Amz-SignedHeaders":"host",
//            ]
//
//            WebServices.uploadFileFinal(url: urlString ?? "", params: params, files: self.files) { response in
//
//            }

           // guard let url = URL(string: para ?? "") else { return }
           // self.uploadImage(url: url)
           // self.uploadFile(url: url)
        }
    }


    func uploadFile(url: URL){
        let request =  self.makeRequestForUpload(fromUrl: url, httpBody: self.dataArray.first, fileName: self.files.first?.fileName ?? "")

//            guard let url = url else {
//        if loader { JGProgress.instance.hideActivity() }
//                return
//            }
        Alamofire.request(request as! URLRequest).responseJSON{ (response) in


//            guard let response = response else {
//               // completion(Response.failure(.none))
//                return
//            }

            let json = JSON(response)

            let responseType = Validate.link(code: json[APIConstants.code].stringValue)

            switch responseType {
            case .success:
            Debug.log("\(Response.success(response))")
            case .failure:
                Debug.log("\(Response.failure(json[APIConstants.message].stringValue))")
            case .notVerified:
                Debug.log()
            case .invalidAccessToken:
                PrescriptionLoaderView.tokenExpired()

            default :
                break
            }



            }
        }

    private static func tokenExpired() {
        Alerts.shared.show(alert: .warning, message: "Your session has expired; please login again.", type: .info)
        let settingViewModel = SettingViewModel()
        settingViewModel.removeAllDataFromUserDefaults()
    }

    func makeRequestForUpload(fromUrl url: URL, httpBody: Data? = nil, fileName: String) -> NSMutableURLRequest? {
        let cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let request = NSMutableURLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 2.0)
        request.httpMethod = "PUT"

        var header : [String: String] = [:]
        let accessToken = AuthManager.shared.accessToken
//        if !(accessToken ?? "").isEmpty {
//            header["Authorization"] = "\(accessToken ?? "")"
//            //header["Content-Type"] = "application/json"
//        }
//        request.allHTTPHeaderFields = header

        // Set Content-Type in HTTP header.
        let boundaryConstant = "Boundary-7MA4YWxkTLLu0UIW"; // This should be auto-generated.
        let contentType = "multipart/form-data; boundary=" + boundaryConstant

        let fileName = fileName

        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")

        var data = Data("--\(boundaryConstant)\r\n".utf8)
        data += Data("Content-Disposition: form-data; name=file; filename=\"\(fileName)\"\r\n".utf8)
        data += Data("Content-Type: octet-stream\r\n\r\n".utf8)
        if let body = httpBody { data += body }
        data += Data("\r\n".utf8)
        data += Data("--\(boundaryConstant)--\r\n".utf8)
        request.httpBody = data

        return request
    }



    func uploadImage(url: URL){

        let imageData = dataArray.first

              Alamofire.upload(imageData!, to: url, method: .put, headers: nil).responseJSON(completionHandler: { (response) in
                  let json =  JSON(response.value)
                  Debug.log("\(json)")
                    })
    }


}

extension PrescriptionLoaderView {

    func uploadImageData(data: Data, urlString: String, mimeType: String, completion: @escaping (Bool, Error?) -> Void) {
        let requestURL = URL(string: urlString)!
        let client = URLSession.shared
        //AFHTTPSessionManager(baseURL: requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue(mimeType, forHTTPHeaderField: "Content-Type")
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("public-read", forHTTPHeaderField: "x-amz-acl")

        let task = client.dataTask(with: request, completionHandler: { (response, responseObject, error) in
            Debug.log("\(response!)" )
            Debug.log("\(error!)")
            completion(error == nil, error)
        })
        task.resume()
    }
}
