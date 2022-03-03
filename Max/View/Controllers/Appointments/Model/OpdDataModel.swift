//
//  OpdDataModel.swift
//  Max
//
//  Created by aravind  yadav on 26/01/22.
//

import Foundation
import ObjectMapper

struct OPDDataModel : Mappable {
    var start_time : String?
    var amount : Int?
    var latest_status : String?
    var doctor_slot_config_id : String?
    var external_slot_id : String?
    var id : String?
    var procedure_info : Procedure_info?
    var patient_id : String?
    var appointment_date : String?
    var doctor : Doctor?
    var attendants : [String]?
    var notes : [Notes]?
    var order_id : String?
    var start_timestamp : Int?
    var doctor_id : String?
    var procedure_id : String?
    var room_id : String?
    var branch_id : String?
    var source : String?
    var patient : Patient?
    var deleted_by_id : String?
    var slot_config_time : String?
    var updated_at : String?
    var account_id : String?
    var queue_no : String?
    var external_booking_no : String?
    var appointment_type : String?
    var end_time : String?
    var created_at : String?
    var end_timestamp : Int?
    var prescription_ready : Bool?
    var deleted_at : String?
    var branch : Branch?
    var external_procedure_id : String?
    var created_by_id : String?
    var updated_by_id : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        start_time <- map["start_time"]
        amount <- map["amount"]
        latest_status <- map["latest_status"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        external_slot_id <- map["external_slot_id"]
        id <- map["id"]
        procedure_info <- map["procedure_info"]
        patient_id <- map["patient_id"]
        appointment_date <- map["appointment_date"]
        doctor <- map["doctor"]
        attendants <- map["attendants"]
        notes <- map["notes"]
        order_id <- map["order_id"]
        start_timestamp <- map["start_timestamp"]
        doctor_id <- map["doctor_id"]
        procedure_id <- map["procedure_id"]
        room_id <- map["room_id"]
        branch_id <- map["branch_id"]
        source <- map["source"]
        patient <- map["patient"]
        deleted_by_id <- map["deleted_by_id"]
        slot_config_time <- map["slot_config_time"]
        updated_at <- map["updated_at"]
        account_id <- map["account_id"]
        queue_no <- map["queue_no"]
        external_booking_no <- map["external_booking_no"]
        appointment_type <- map["appointment_type"]
        end_time <- map["end_time"]
        created_at <- map["created_at"]
        end_timestamp <- map["end_timestamp"]
        prescription_ready <- map["prescription_ready"]
        deleted_at <- map["deleted_at"]
        branch <- map["branch"]
        external_procedure_id <- map["external_procedure_id"]
        created_by_id <- map["created_by_id"]
        updated_by_id <- map["updated_by_id"]
    }
}

struct GenderMaster : Mappable {
    var account_id : String?
    var created_by_id : String?
    var updated_by_id : String?
    var id : String?
    var name : String?
    var deleted_by_id : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        account_id <- map["account_id"]
        created_by_id <- map["created_by_id"]
        updated_by_id <- map["updated_by_id"]
        id <- map["id"]
        name <- map["name"]
        deleted_by_id <- map["deleted_by_id"]
    }
}

struct Notes : Mappable {
    var type : String?
    var deleted_at : String?
    var created_at : String?
    var account_id : String?
    var deleted_by_id : String?
    var note_by : String?
    var appointment_id : String?
    var created_by_id : String?
    var note : String?
    var id : String?
    var updated_by_id : String?
    var updated_at : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        type <- map["type"]
        deleted_at <- map["deleted_at"]
        created_at <- map["created_at"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        note_by <- map["note_by"]
        appointment_id <- map["appointment_id"]
        created_by_id <- map["created_by_id"]
        note <- map["note"]
        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        updated_at <- map["updated_at"]
    }
}

struct Procedure_info : Mappable {
    var account_id : String?
    var created_by_id : String?
    var updated_by_id : String?
    var id : String?
    var name : String?
    var deleted_by_id : String?

    init(){}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        account_id <- map["account_id"]
        created_by_id <- map["created_by_id"]
        updated_by_id <- map["updated_by_id"]
        id <- map["id"]
        name <- map["name"]
        deleted_by_id <- map["deleted_by_id"]
    }
}

//-Mark --slots/doctor-slot-config

struct DoctorSlotConfigModel : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var doctor_id : String?
    var branch_id : String?
    var start_time : String?
    var end_time : String?
    var external_slot_id : String?
    var session_start_date : String?
    var session_end_date : String?
    var start_time_minutes : Int?
    var end_time_minutes : Int?
    var protocoll : String?
    var is_tatkal : Bool?
    var tatkal_days : String?
    var is_active : Bool?
    var practice_status : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var availability_days : [Availability_days]?
    var property : String?

    init?(map: Map) {

    }
    init(){}

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        doctor_id <- map["doctor_id"]
        branch_id <- map["branch_id"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        external_slot_id <- map["external_slot_id"]
        session_start_date <- map["session_start_date"]
        session_end_date <- map["session_end_date"]
        start_time_minutes <- map["start_time_minutes"]
        end_time_minutes <- map["end_time_minutes"]
        protocoll <- map["protocol"]
        is_tatkal <- map["is_tatkal"]
        tatkal_days <- map["tatkal_days"]
        is_active <- map["is_active"]
        practice_status <- map["practice_status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        availability_days <- map["availability_days"]
        property <- map["property"]
    }

}

struct Availability_days : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var doctor_slot_config_id : String?
    var day_master_id : String?
    var week : [String]?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var day : Day?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        day_master_id <- map["day_master_id"]
        week <- map["week"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        day <- map["day"]
    }

}

struct Day : Mappable {
    var id : String?
    var updated_by_id : String?
    var created_by_id : String?
    var account_id : String?
    var deleted_by_id : String?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        updated_by_id <- map["updated_by_id"]
        created_by_id <- map["created_by_id"]
        account_id <- map["account_id"]
        deleted_by_id <- map["deleted_by_id"]
        name <- map["name"]
    }

}
