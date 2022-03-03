//
//  RescheduleAppointmentModel.swift
//  Max
//
//  Created by Ankit on 09/02/22.
//

import Foundation
import ObjectMapper

struct RescheduleAppointmentModel: Mappable {

    var selectedDate = Date()
    var branch_id: String?
    var procedure_id: String?
    var procedureName: String?
    var selectedSlot: Slots?
    var slot:SlotModel?
    
    init?(map: Map) {}

    init() {}

    mutating func mapping(map: Map) {

    }


}
