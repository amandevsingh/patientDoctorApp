

import Foundation

internal extension String {
    var hasOnlyNewlineSymbols: Bool {
        return trimmingCharacters(in: CharacterSet.newlines).isEmpty
    }
    
    func eventDate() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        return formatter.date(from: self)!
    }
    
    func eventSectionDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateIntermediate = formatter.date(from: self)
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: dateIntermediate!)
    }
    
    func eventSectionDateSort() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let tempDate = formatter.date(from: self)
        return (tempDate == nil) ? Date() : tempDate!
    }
    
    func notificationDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateIntermediate = formatter.date(from: self)
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: dateIntermediate!)
    }
}

//Validation
extension String {

    var isValidMobileNumber : Bool {
        let regex = "^((\\+91)?|91)?[789][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = phoneTest.evaluate(with: self)
        return result
    }

}
