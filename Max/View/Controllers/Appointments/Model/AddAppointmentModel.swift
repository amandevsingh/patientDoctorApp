//
//  AddAppointmentModel.swift
//  Max
//
//  Created by Ankit on 26/01/22.
//

import Foundation
import ObjectMapper

    //MARK:- Add Appointment
    struct AddAppointmentModel: Mappable {
        var branch : Branch?
        var nationalityList: [NationalityModel]?
        var procedures: [ProcedureItem]?
        var slot:SlotModel?
        var patients: [PatientModel]?
        var gender: [Gender]?
        var selectedHospitalBranchItem: Items?
        var selectedNation: NationalityModel?
        var selectedAppointment: ProcedureItem?
        var selectedSlot: Slots?
        var selectedPatient: PatientModel?
        var selectedGender: Gender?
        var newPatientFirstName: String?
        var newPatientLastName: String?
        var newPatientPhoneNumber: String?
        var newPatientDOB: Date?
        var newPatientEmailID: String?
        

        init?(map: Map) {}
        init(){}

        mutating func mapping(map: Map) {
          branch <- map["branch"]
        }
    }

    //Save branch
    struct Branch : Mappable {
        var items : [Items]?
        var total : Int?
        var offset : Int?
        var limit : Int?

        init?(map: Map) {}

        mutating func mapping(map: Map) {
            items <- map["items"]
            total <- map["total"]
            offset <- map["offset"]
            limit <- map["limit"]
        }
    }

    struct Items : Mappable {
        var id : String?
        var updated_by_id : String?
        var created_by_id : String?
        var account_id : String?
        var deleted_by_id : String?
        var name : String?
        var code : String?
        var external_id : String?
        var city : String?
        var region : String?
        var phone : String?
        var created_at : String?
        var updated_at : String?
        var deleted_at : String?

        init?(map: Map) {}

        mutating func mapping(map: Map) {
            id <- map["id"]
            updated_by_id <- map["updated_by_id"]
            created_by_id <- map["created_by_id"]
            account_id <- map["account_id"]
            deleted_by_id <- map["deleted_by_id"]
            name <- map["name"]
            code <- map["code"]
            external_id <- map["external_id"]
            city <- map["city"]
            region <- map["region"]
            phone <- map["phone"]
            created_at <- map["created_at"]
            updated_at <- map["updated_at"]
            deleted_at <- map["deleted_at"]
        }
    }

struct DepartmentModel: Mappable {

    init(){}

    init?(map: Map) {}

    mutating func mapping(map: Map) {

    }

}

/*
 {
       "id": "39aaace8-d98a-4ca8-853f-94511e56f969",
       "name": "Indian",
       "image_url": null
     }
 */

struct NationalityModel: Mappable {

    var id: String?
    var name: String?
    var imageURL: String?

    init(){}

    init?(map: Map) {}

    mutating func mapping(map: Map) {
     id <- map["id"]
     name <- map["name"]
    imageURL <- map["image_url"]
    }
}


struct ProcedureItem: Mappable {

    var id: String?
    var name: String?

    init(){}
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }

}

//SLOTS
struct SlotModel : Mappable {
    var availableSlots : [AvailableSlots]?
    var nextAvailable : [NextAvailable]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        availableSlots <- map["availableSlots"]
        nextAvailable <- map["nextAvailable"]
    }
}

struct AvailableSlots : Mappable {
    var appointment_date : String?
    var appointment_count : Int?
    var procedures : [SlotProcedures]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        appointment_date <- map["appointment_date"]
        appointment_count <- map["appointment_count"]
        procedures <- map["procedures"]
    }

}

struct SlotProcedures : Mappable {
    var procedure_name : String?
    var procedure_id : String?
    var branches : [SlotBranches]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        procedure_name <- map["procedure_name"]
        procedure_id <- map["procedure_id"]
        branches <- map["branches"]
    }

}

struct NextAvailable : Mappable {
    var procedure_name : String?
    var s_time : String?
    var branch : String?
    var s_date : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        procedure_name <- map["procedure_name"]
        s_time <- map["s_time"]
        branch <- map["branch"]
        s_date <- map["s_date"]
    }

}

struct SlotBranches : Mappable {
    var branch_name : String?
    var slot_start_time : String?
    var slot_end_time : String?
    var fee : Int?
    var interval : Int?
    var slots : [Slots]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        branch_name <- map["branch_name"]
        slot_start_time <- map["slot_start_time"]
        slot_end_time <- map["slot_end_time"]
        fee <- map["fee"]
        interval <- map["interval"]
        slots <- map["slots"]
    }

}

struct Slots : Mappable {
    var slot_id : String?
    var s_time : String?
    var fee : Int?
    var interval : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        slot_id <- map["slot_id"]
        s_time <- map["s_time"]
        fee <- map["fee"]
        interval <- map["interval"]
    }

}


//PATIENTS LIST
struct PatientModel : Mappable {
    var emergency_contact_mobile : String?
    var uhid : String?
    var name : String?
    var age : Int?
    var marital_status : String?
    var dob : String?
    var mobile : String?
    var nationality_id : String?
    var gender_id : String?
    var birth_year : Int?
    var tags : String?
    var id : String?
    var blood_group_id : String?
    var patient_type : String?
    var nationality : String?
    var gender : String?
    var emergency_contact_relationship : String?
    var emergency_contact_name : String?
    var email : String?
    var addresses : String?
    var blood_group : String?
    var marital_status_id : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        emergency_contact_mobile <- map["emergency_contact_mobile"]
        uhid <- map["uhid"]
        name <- map["name"]
        age <- map["age"]
        marital_status <- map["marital_status"]
        dob <- map["dob"]
        mobile <- map["mobile"]
        nationality_id <- map["nationality_id"]
        gender_id <- map["gender_id"]
        birth_year <- map["birth_year"]
        tags <- map["tags"]
        id <- map["id"]
        blood_group_id <- map["blood_group_id"]
        patient_type <- map["patient_type"]
        nationality <- map["nationality"]
        gender <- map["gender"]
        emergency_contact_relationship <- map["emergency_contact_relationship"]
        emergency_contact_name <- map["emergency_contact_name"]
        email <- map["email"]
        addresses <- map["addresses"]
        blood_group <- map["blood_group"]
        marital_status_id <- map["marital_status_id"]
    }

}

//gender
struct Gender: Mappable {
    var id : String?
    var name: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
    
 //--UploadFile--
    
    struct UploadFile : Mappable {
        var url : String?
        var id : String?

        init?(map: Map) {}
        init(){}
        mutating func mapping(map: Map) {

            url <- map["url"]
            id <- map["id"]
        }

    }


