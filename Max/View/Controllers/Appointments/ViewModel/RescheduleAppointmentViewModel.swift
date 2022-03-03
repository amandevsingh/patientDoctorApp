//
//  RescheduleAppointmentViewModel.swift
//  Max
//
//  Created by Ankit on 09/02/22.
//

import Foundation

class RescheduleAppointmentViewModel {

    private var rescheduleAppointmentModel = RescheduleAppointmentModel()

    func setBranchID(id: String) {
        rescheduleAppointmentModel.branch_id = id
    }

    func setProcedureID(procedure_Info: Procedure_info?) {
       rescheduleAppointmentModel.procedure_id = procedure_Info?.id
    }

    func setProcedureName(procedure_Info: Procedure_info?) {
       rescheduleAppointmentModel.procedureName = procedure_Info?.name
    }

    lazy var dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = .current
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter
    }()

    func setSelectedDate(date: Date) {
    rescheduleAppointmentModel.selectedDate = date
    }

    func selectedDateInString() -> String {
    return (self.dateFormatter.string(from: rescheduleAppointmentModel.selectedDate))
    }

    func getSlots() -> [String]? {
        var availableSlots = [String]()
        for item in rescheduleAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots ?? [] {
            availableSlots.append((item.s_time ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return availableSlots
    }

    func setSelectedSlot(index: Int) {
        if rescheduleAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots?.count ?? 0 > 0 {
            rescheduleAppointmentModel.selectedSlot = rescheduleAppointmentModel.slot?.availableSlots?.first?.procedures?.first?.branches?.first?.slots?[index]
        }
    }

    func setSelectedSlotToNil(){
        rescheduleAppointmentModel.selectedSlot = nil
    }

    func rescheduleAppointment(completion: @escaping (() -> ())) {
        var params = [String: Any]()
        params["procedure_id"] = rescheduleAppointmentModel.procedure_id//"a02bad00-0309-4bda-a2c7-eacf93e7ec51"
        params["slot_id"] = rescheduleAppointmentModel.selectedSlot?.slot_id//"34844834-92f0-4722-93af-3a1a1903ab67"
        params["source"] = "web"
        params["slot_time"] = rescheduleAppointmentModel.selectedSlot?.s_time//"11:40 AM"
        params["procedure_type"] = rescheduleAppointmentModel.procedureName//"Consultation"
        params["branch_id"] = rescheduleAppointmentModel.branch_id//"3d215223-8126-4c71-9214-eb263a40c150"
        params["fee"] = "10"
        params["date"] = selectedDateInString() //"2022-02-14"
        params["status"] = "re-scheduled"
        WebServices.rescheduleAppointment(params: params) { response in
            if let response = response {
              if response.statusCode == 200{
               completion()
              }
            }
        }
    }

    func getSlots(completion: @escaping (() -> Void)) {
       var params = [String: Any]()
        params["doctor_id"] = AuthManager.shared.doctor_id //"4c686467-59ed-4f13-8ab0-9563642b930d"//
        params["branch_id"] = rescheduleAppointmentModel.branch_id
        //"3d215223-8126-4c71-9214-eb263a40c150"//branchID
        params["procedure_id"] = rescheduleAppointmentModel.procedure_id
            //"c1cecec2-b018-4ea9-b11d-5223edf44f8e" //procedureID
       // params["slot_date"] =  selectedDateInString() //"2022-02-07"

        WebServices.getAvailableSlots(params: params) { response in
            if let response = response {
                if let obj = response.object {
                 self.rescheduleAppointmentModel.slot = obj
                 completion()
                }
            }
        }
    }

}
