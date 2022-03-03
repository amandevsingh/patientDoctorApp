/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper


struct IpdData : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var patient_id : String?
    var doctor_id : String?
    var branch_id : String?
    var admission_date : String?
    var discharge_date : String?
    var type : String?
    var pay_type : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var doctor : Doctor?
    var patient : Patient?
    var branch : Branch?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        patient_id <- map["patient_id"]
        doctor_id <- map["doctor_id"]
        branch_id <- map["branch_id"]
        admission_date <- map["admission_date"]
        discharge_date <- map["discharge_date"]
        type <- map["type"]
        pay_type <- map["pay_type"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        doctor <- map["doctor"]
        patient <- map["patient"]
        branch <- map["branch"]
    }

}
struct Doctor : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var reg_no : String?
    var name : String?
    var dob : String?
    var external_id : String?
    var birth_year : Int?
    var practicing_since : Int?
    var qualification : String?
    var reg_council : String?
    var gender_id : String?
    var designation_id : String?
    var user_profile_id : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        reg_no <- map["reg_no"]
        name <- map["name"]
        dob <- map["dob"]
        external_id <- map["external_id"]
        birth_year <- map["birth_year"]
        practicing_since <- map["practicing_since"]
        qualification <- map["qualification"]
        reg_council <- map["reg_council"]
        gender_id <- map["gender_id"]
        designation_id <- map["designation_id"]
        user_profile_id <- map["user_profile_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}


struct Patient : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var uhid : String?
    var dob : String?
    var patient_type : String?
    var birth_year : Int?
    var gender_id : String?
    var marital_status_id : String?
    var blood_group_id : String?
    var nationality_id : String?
    var property_id : String?
    var is_mobile_verified : Bool?
    var is_email_verified : Bool?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var pii : Pii?
    var genderMaster: GenderMaster?

     init(){}
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        uhid <- map["uhid"]
        dob <- map["dob"]
        patient_type <- map["patient_type"]
        birth_year <- map["birth_year"]
        gender_id <- map["gender_id"]
        marital_status_id <- map["marital_status_id"]
        blood_group_id <- map["blood_group_id"]
        nationality_id <- map["nationality_id"]
        property_id <- map["property_id"]
        is_mobile_verified <- map["is_mobile_verified"]
        is_email_verified <- map["is_email_verified"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        pii <- map["pii"]
        genderMaster <- map["genderMaster"]
    }

}


struct Pii : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var patient_id : String?
    var name : String?
    var first_name : String?
    var last_name : String?
    var mobile : String?
    var email : String?
    var emergency_contact_name : String?
    var emergency_contact_mobile : String?
    var emergency_contact_relationship : String?
    var profile_pic_id : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    init(){}
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        patient_id <- map["patient_id"]
        name <- map["name"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        mobile <- map["mobile"]
        email <- map["email"]
        emergency_contact_name <- map["emergency_contact_name"]
        emergency_contact_mobile <- map["emergency_contact_mobile"]
        emergency_contact_relationship <- map["emergency_contact_relationship"]
        profile_pic_id <- map["profile_pic_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}
