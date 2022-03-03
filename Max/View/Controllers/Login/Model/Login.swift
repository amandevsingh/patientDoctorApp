//
//  Login.swift
//  Max
//
//  Created by Rahul on 23/12/21.
//

import Foundation
import ObjectMapper

struct Login: Mappable {

    var countryCode: String = "+91"
    var mobileNumber: String?
    var session_id: String?

    init(){}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
     session_id <- map["session_id"]
    }


}

