//
//  ApplicationTypeModel.swift
//  Max
//
//  Created by aravind  yadav on 12/02/22.
//

import Foundation
import ObjectMapper

struct ApplicationTypeModel : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var name : String?
    var slug : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?

    init?(map: Map) {}
    init(){}

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        name <- map["name"]
        slug <- map["slug"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}
