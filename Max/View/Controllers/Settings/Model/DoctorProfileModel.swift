//
//  DoctorProfileModel.swift
//  Max
//
//  Created by aravind  yadav on 13/02/22.
//
import Foundation
import ObjectMapper

struct DoctorProfileModel : Mappable {
    var id : String?
    var reg_no : String?
    var name : String?
    var country_code : String?
    var mobile : String?
    var email : String?
    var dob : String?
    var birth_year : Int?
    var gender : String?
    var qualification : String?
    var practicing_since : Int?
    var reg_council : String?
    var designation : String?
    var branches : String?
    var departments : String?
    var specialities : String?
    var gender_id : String?
    var designation_id : String?
    var profile_pic : String?
    var exp : String?
    var fees : Int?
    var doc_schedule : [Doc_schedule]?
    var consultation_slots : String?
    var vc_slots : String?

    init?(map: Map) {

    }

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
        profile_pic <- map["profile_pic"]
        exp <- map["exp"]
        fees <- map["fees"]
        doc_schedule <- map["doc_schedule"]
        consultation_slots <- map["consultation_slots"]
        vc_slots <- map["vc_slots"]
    }

}


struct Doc_schedule : Mappable {
    var procedure : String?
    var branch : String?
    var start_time : String?
    var end_time : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        procedure <- map["procedure"]
        branch <- map["branch"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
    }

}

