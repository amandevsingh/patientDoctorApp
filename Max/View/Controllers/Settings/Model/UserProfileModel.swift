//
//  UserProfileModel.swift
//  Max
//
//  Created by Ankit on 25/01/22.
//

import Foundation
import ObjectMapper

struct UserProfileModel: Mappable {
    var id : String?
    var reg_no: String?
    var name: String?
    var country_code: String?
    var mobile: String?
    var email: String?
    var dob: String?
    var birth_year: Int?
    var gender: String?
    var qualification: String?
    var practicing_since: Int?
    var reg_council: String?
    var designation: String?
    var branches: String?
    var departments: String?
    var specialities:String?
    var gender_id: String?
    var designation_id: String?
    var external_id: String?

    init(){}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        reg_no <- map["reg_no"]
        name <- map["name"]
        country_code <- map["country_code"]
        mobile <- map["mobile"]
        email <- map["email"]
        dob <- map["dob"]
        birth_year <- map["birth_year"]
        gender <- map["gender"]
        qualification <- map["qualification"]
        practicing_since <- map["practicing_since"]
        reg_council <- map["reg_council"]
        designation <- map["designation"]
        branches <- map["branches"]
        departments <- map["departments"]
        specialities <- map["specialities"]
        gender_id <- map["gender_id"]
        designation_id <- map["designation_id"]
        external_id <- map["external_id"]
    }
}
