//
//  NoShowViewModel.swift
//  Max
//
//  Created by Ankit on 07/02/22.
//

import Foundation

class NoShowViewModel {

    func toggleAppointmentStatus(completion: @escaping (() -> ())) {
    var params = [String: Any]()
    params["status"] = "no-show"
    WebServices.toggleAppointmentStatus(params:params) { response in
    completion()
    }
    }
//https://medi.hlthclub.in/vault/v1/appointments/status/c631f70a-a346-4713-97a8-f3e393f7d531
}
