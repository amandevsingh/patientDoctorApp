//
//  VerifyOtp.swift
//  Max
//
//  Created by aravind  yadav on 23/01/22.
//

import Foundation
import ObjectMapper
struct VerifyOtp: Mappable {

    var otp: String?
    var access_token: String?

    init(){}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        access_token <- map["access_token"]
        
    }

}
