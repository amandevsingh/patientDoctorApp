//
//  UploadedDocModel.swift
//  Max
//
//  Created by aravind  yadav on 01/02/22.
//

import Foundation
import ObjectMapper

struct UploadedDocModel : Mappable {
    var error : String?
    var result : String?

    init?(map: Map) {}
    init(){}
    

    mutating func mapping(map: Map) {

        error <- map["error"]
        result <- map["result"]
    }

}
