/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper
import ObjectMapper

struct AppointmentDataModel : Mappable {
   
    var items : [AppointmentModel]?
    var message : String?
    var statusCode : Int?
    
       
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        items <- map["items"]
        message <- map["message"]
        statusCode <- map["statusCode"]
    }
}


struct AppointmentModel :Mappable {
    
    var appointments : [Appointments]?
    var appointment_date : String?
    var branch_id : String?
    var branch_name : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        appointments <- map["appointments"]
        appointment_date <- map["appointment_date"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
    }
}

struct Appointments : Mappable {
    var slot_start_time : String?
    var practice_status : String?
    var total_count : String?
    var doctor_slot_config_id : String?
    var shift_completed : Bool?
    var appointment_type : String?
    var slot_end_time : String?
    var procedures : [Procedures]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        slot_start_time <- map["slot_start_time"]
        practice_status <- map["practice_status"]
        total_count <- map["total_count"]
        doctor_slot_config_id <- map["doctor_slot_config_id"]
        shift_completed <- map["shift_completed"]
        appointment_type <- map["appointment_type"]
        slot_end_time <- map["slot_end_time"]
        procedures <- map["procedures"]
    }

}

struct Procedures : Mappable {
    var appointment_count : Int?
    var procedure_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        appointment_count <- map["appointment_count"]
        procedure_name <- map["procedure_name"]
    }

}


