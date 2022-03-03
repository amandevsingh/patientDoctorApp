//
//  OverloadedOperators.swift
//  Max
//
//  Created by Rahul on 28/12/21.
//

import Foundation
import UIKit
//import SwiftyJSON

typealias EmptyBlock = () -> ()
//typealias OptionalJSON = [String : JSON]?

prefix operator /
prefix operator £

prefix func /(value: Int?) -> Int {
    return value ?? 0
}

//prefix func /(value: [JSON]?) -> [JSON] {
//    return value ?? []
//}

prefix func /(value : String?) -> String {
    return value ?? ""
}

prefix func /(value : Double?) -> Double {
    return value ?? 0.0
}

prefix func /(value : Float?) -> Float {
    return value ?? 0.0
}
prefix func /(value : CGFloat?) -> CGFloat {
    return value ?? 0.0
}

prefix func /(value : Bool?) -> Bool {
    return value ?? false
}

prefix func £(value : String?) -> String {
    return (value ?? "0") + " " + ""
}

prefix func /(value : IndexPath?) -> IndexPath {
    return value ?? IndexPath()
}


infix operator =>
infix operator =|
infix operator =/


//func =>(key : String, json : OptionalJSON) -> String{
//    return /json?[key]?.stringValue
//}

//func =|(key : String, json : OptionalJSON) -> [JSON]{
//    return /(json?[key]?.arrayValue)
//}

