//
//  Validations.swift
//  Mstrataspot
//
//  Created by Maahi on 12/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class Validations: NSObject {

    
    class func isValidEmail(_ testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    class func IsValidPhone(_ phonenumber : String) -> Bool {
        
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: phonenumber, options: [], range: NSMakeRange(0, phonenumber.characters.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phonenumber.characters.count && phonenumber.characters.count == 10
            } else {
                return false
            }
        } catch {
            return false
        }
        
    }
    
    
}
