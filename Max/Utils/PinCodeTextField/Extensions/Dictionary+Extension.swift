//
//  Dictionary+Extension.swift
//  Max
//
//  Created by Ankit on 25/01/22.
//

import Foundation

extension Dictionary {

    func changeToString() -> String {
        let stringValue = (self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
     return stringValue
    }

}
