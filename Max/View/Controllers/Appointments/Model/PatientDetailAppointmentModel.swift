//
//  PatientDetailAppointmentModel.swift
//  Max
//
//  Created by Ankit on 07/02/22.
//

import Foundation
import ObjectMapper

struct PatientDetailAppointmentModel : Mappable {
    var new_appointment : String?
    var bill_ready : Bool?
    var doctor_id : String?
    var deleted_at : String?
    var source : String?
    var order_id : String?
    var branch_id : String?
    var updated_at : String?
    var deleted_by_id : String?
    var created_at : String?
    var patient : Patient?
    var end_timestamp : Int?
    var slot_config_time : String?
    var patient_id : String?
    var branch : Branch?
    var notes : [Notes]?
    var vitals_ready : Bool?
    var external_booking_no : String?
    var attendants : [String]?
    var latest_status : String?
    var procedure_info : Procedure_info?
    var doctor_slot_config_id : String?
    var updated_by_id : String?
    var room_id : String?
    var doctor : Doctor?
    var created_by_id : String?
    var labreport_ready : Bool?
    var amount : Int?
    var start_timestamp : Int?
    var external_slot_id : String?
    var id : String?
    var start_time : String?
    var appointment_type : String?
    var end_time : String?
    var procedure_id : String?
    var queue_no : String?
    var appointment_date : String?
    var account_id : String?
    var external_procedure_id : String?
    var prescription_ready : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        new_appointment <- map["new_appointment"]
        bill_ready <- map["bill_ready"]
        doctor_id <- map["doctor_id"]
        deleted_at <- map["deleted_at"]
        source <- map["source"]
        order_id <- map["order_id"]
        branch_id <- map["branch_id"]
        updated_at <- map["updated_at"]
        deleted_by_id <- map["deleted_by_id"]
        created_at <- map["created_at"]
        patient <- map["patient"]
        end_timestamp <- map["end_timestamp"]
        slot_config_time <- map["slot_config_time"]
        patient_id <- map["patient_id"]
        branch <- map["branch"]
        notes <- map["notes"]
        vitals_ready <- map["vitals_ready"]
        external_booking_no <- map["external_booking_no"]
        attendants <- map["attendants"]
        latest_status <- map["latest_status"]
        procedure_info <- map["procedure_info"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        updated_by_id <- map["updated_by_id"]
        room_id <- map["room_id"]
        doctor <- map["doctor"]
        created_by_id <- map["created_by_id"]
        labreport_ready <- map["labreport_ready"]
        amount <- map["amount"]
        start_timestamp <- map["start_timestamp"]
        external_slot_id <- map["external_slot_id"]
        id <- map["id"]
        start_time <- map["start_time"]
        appointment_type <- map["appointment_type"]
        end_time <- map["end_time"]
        procedure_id <- map["procedure_id"]
        queue_no <- map["queue_no"]
        appointment_date <- map["appointment_date"]
        account_id <- map["account_id"]
        external_procedure_id <- map["external_procedure_id"]
        prescription_ready <- map["prescription_ready"]
    }

}
