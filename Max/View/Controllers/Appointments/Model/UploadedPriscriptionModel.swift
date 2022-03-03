//
//  UploadedPriscriptionModel.swift
//  Max
//
//  Created by aravind  yadav on 30/01/22.
//

import Foundation
import ObjectMapper

struct UploadedPriscriptionModel : Mappable {
    var items : [ItemsData]?
    var total : Int?
    var offset : Int?
    var limit : Int?

    init?(map: Map) {}
    init(){}

    mutating func mapping(map: Map) {

        items <- map["items"]
        total <- map["total"]
        offset <- map["offset"]
        limit <- map["limit"]
    }

}

struct ItemsData : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var appointment_id : String?
    var template_id : String?
    var date : String?
    var type : String?
    var data_id : String?
    var name : String?
    var content_type : String?
    var patient_id : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var appointment : Appointment?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        appointment_id <- map["appointment_id"]
        template_id <- map["template_id"]
        date <- map["date"]
        type <- map["type"]
        data_id <- map["data_id"]
        name <- map["name"]
        content_type <- map["content_type"]
        patient_id <- map["patient_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        appointment <- map["appointment"]
    }

}

struct Appointment : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var doctor_id : String?
    var branch_id : String?
    var patient_id : String?
    var appointment_date : String?
    var start_time : String?
    var end_time : String?
    var start_timestamp : Int?
    var end_timestamp : Int?
    var source : String?
    var latest_status : String?
    var external_slot_id : String?
    var external_procedure_id : String?
    var procedure_id : String?
    var appointment_type : String?
    var amount : Int?
    var queue_no : String?
    var external_booking_no : String?
    var doctor_slot_config_id : String?
    var slot_config_time : String?
    var order_id : String?
    var room_id : String?
    var prescription_ready : Bool?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var branch : Branch?
    var doctor : Doctor?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        doctor_id <- map["doctor_id"]
        branch_id <- map["branch_id"]
        patient_id <- map["patient_id"]
        appointment_date <- map["appointment_date"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        start_timestamp <- map["start_timestamp"]
        end_timestamp <- map["end_timestamp"]
        source <- map["source"]
        latest_status <- map["latest_status"]
        external_slot_id <- map["external_slot_id"]
        external_procedure_id <- map["external_procedure_id"]
        procedure_id <- map["procedure_id"]
        appointment_type <- map["appointment_type"]
        amount <- map["amount"]
        queue_no <- map["queue_no"]
        external_booking_no <- map["external_booking_no"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        slot_config_time <- map["slot_config_time"]
        order_id <- map["order_id"]
        room_id <- map["room_id"]
        prescription_ready <- map["prescription_ready"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        branch <- map["branch"]
        doctor <- map["doctor"]
    }

}
