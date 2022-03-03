//
//  PrescriptionModel.swift
//  Max
//
//  Created by Ankit on 30/01/22.
//

import Foundation
import ObjectMapper

struct PrescriptionModel : Mappable {
    var items : [PrescriptionItems]?
    var offset : Int?
    var total : Int?
    var limit : Int?
    var no_show_status: Bool = true
    var branch_id: String = ""
    var procedure_Info: Procedure_info?
    var notes : [Notes]?
    
    init(){}
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        items <- map["items"]
        offset <- map["offset"]
        total <- map["total"]
        limit <- map["limit"]
    }
}

struct PrescriptionItems : Mappable {
    var created_by_id : String?
    var date : String?
    var type : String?
    var updated_by_id : String?
    var deleted_at : String?
    var name : String?
    var appointment_id : String?
    var id : String?
    var created_at : String?
    var appointment : PrescriptionAppointment?
    var template_id : String?
    var content_type : String?
    var patient_id : String?
    var data_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var updated_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        created_by_id <- map["created_by_id"]
        date <- map["date"]
        type <- map["type"]
        updated_by_id <- map["updated_by_id"]
        deleted_at <- map["deleted_at"]
        name <- map["name"]
        appointment_id <- map["appointment_id"]
        id <- map["id"]
        created_at <- map["created_at"]
        appointment <- map["appointment"]
        template_id <- map["template_id"]
        content_type <- map["content_type"]
        patient_id <- map["patient_id"]
        data_id <- map["data_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        updated_at <- map["updated_at"]
    }

}

struct PrescriptionAppointment : Mappable {
    var latest_status : String?
    var doctor_id : String?
    var external_slot_id : String?
    var doctor : PrescriptionDoctor?
    var queue_no : String?
    var doctor_slot_config_id : String?
    var order_id : String?
    var created_by_id : String?
    var id : String?
    var room_id : String?
    var updated_at : String?
    var end_timestamp : Int?
    var slot_config_time : String?
    var branch : PrescriptionBranch?
    var prescription_ready : Bool?
    var start_time : String?
    var amount : Int?
    var patient_id : String?
    var start_timestamp : Int?
    var updated_by_id : String?
    var branch_id : String?
    var external_procedure_id : String?
    var procedure_id : String?
    var end_time : String?
    var appointment_type : String?
    var external_booking_no : String?
    var appointment_date : String?
    var deleted_at : String?
    var deleted_by_id : String?
    var source : String?
    var created_at : String?
    var account_id : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        latest_status <- map["latest_status"]
        doctor_id <- map["doctor_id"]
        external_slot_id <- map["external_slot_id"]
        doctor <- map["doctor"]
        queue_no <- map["queue_no"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        order_id <- map["order_id"]
        created_by_id <- map["created_by_id"]
        id <- map["id"]
        room_id <- map["room_id"]
        updated_at <- map["updated_at"]
        end_timestamp <- map["end_timestamp"]
        slot_config_time <- map["slot_config_time"]
        branch <- map["branch"]
        prescription_ready <- map["prescription_ready"]
        start_time <- map["start_time"]
        amount <- map["amount"]
        patient_id <- map["patient_id"]
        start_timestamp <- map["start_timestamp"]
        updated_by_id <- map["updated_by_id"]
        branch_id <- map["branch_id"]
        external_procedure_id <- map["external_procedure_id"]
        procedure_id <- map["procedure_id"]
        end_time <- map["end_time"]
        appointment_type <- map["appointment_type"]
        external_booking_no <- map["external_booking_no"]
        appointment_date <- map["appointment_date"]
        deleted_at <- map["deleted_at"]
        deleted_by_id <- map["deleted_by_id"]
        source <- map["source"]
        created_at <- map["created_at"]
        account_id <- map["account_id"]
    }

}

struct PrescriptionDoctor : Mappable {
    var id : String?
    var reg_no : String?
    var deleted_at : String?
    var gender_id : String?
    var updated_at : String?
    var created_at : String?
    var user_profile_id : String?
    var dob : String?
    var reg_council : String?
    var deleted_by_id : String?
    var created_by_id : String?
    var practicing_since : Int?
    var updated_by_id : String?
    var name : String?
    var birth_year : Int?
    var external_id : String?
    var designation_id : String?
    var account_id : String?
    var qualification : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        reg_no <- map["reg_no"]
        deleted_at <- map["deleted_at"]
        gender_id <- map["gender_id"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        user_profile_id <- map["user_profile_id"]
        dob <- map["dob"]
        reg_council <- map["reg_council"]
        deleted_by_id <- map["deleted_by_id"]
        created_by_id <- map["created_by_id"]
        practicing_since <- map["practicing_since"]
        updated_by_id <- map["updated_by_id"]
        name <- map["name"]
        birth_year <- map["birth_year"]
        external_id <- map["external_id"]
        designation_id <- map["designation_id"]
        account_id <- map["account_id"]
        qualification <- map["qualification"]
    }

}

struct PrescriptionBranch : Mappable {
    var id : String?
    var code : String?
    var deleted_at : String?
    var phone : String?
    var updated_at : String?
    var created_at : String?
    var city : String?
    var region : String?
    var deleted_by_id : String?
    var created_by_id : String?
    var updated_by_id : String?
    var name : String?
    var external_id : String?
    var account_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        code <- map["code"]
        deleted_at <- map["deleted_at"]
        phone <- map["phone"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        city <- map["city"]
        region <- map["region"]
        deleted_by_id <- map["deleted_by_id"]
        created_by_id <- map["created_by_id"]
        updated_by_id <- map["updated_by_id"]
        name <- map["name"]
        external_id <- map["external_id"]
        account_id <- map["account_id"]
    }

}
