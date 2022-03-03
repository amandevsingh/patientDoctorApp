//
//  ResponseData.swift
//  Max
//
//  Created by Ankit on 22/01/22.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class ResponseData < T: Mappable >: Mappable{
    var message: String?
    var object: T?
    var clientCode: String?
    var array : [T]?
    var statusCode: Int?
    var notification_count: Int = 0
    var error:Bool?
    required init?(map: Map){
    }

    func mapping(map: Map){
        message <- map["message"]
        object <- map["data"]
        array <- map["data"]
        statusCode <- map["statusCode"]
        clientCode <- map["data"]
        error <- map["error"]
        notification_count <- map["notification_count"]
    }
}

