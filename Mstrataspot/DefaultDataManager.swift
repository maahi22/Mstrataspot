//
//  DefaultDataManager.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/12/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class DefaultDataManager: NSObject {

    class func SavePhotoToCameraRoll(_ isSave :Bool){
        
      let kUserDefault = UserDefaults.standard
        if(isSave){
            kUserDefault.set(isSave, forKey: "SavePhotoToCameraRoll")
            
        }else{
            kUserDefault.set(isSave, forKey: "SavePhotoToCameraRoll")
        }
        
        kUserDefault.synchronize()
        
    }
    
    class func ShouldSavePhotoToCameraRoll() -> Bool{
        
        let kUserDefault = UserDefaults.standard
        if let saveOption = kUserDefault.value(forKey: "SavePhotoToCameraRoll")  {
            return saveOption as! Bool
        }
        return false
        
    }
    
    class func LastTotalReportSendDate()->String{
        let kUserDefault = UserDefaults.standard
        
        if let lasttotal = kUserDefault.value(forKey: "LastTotalReportSendDate")  {
            return lasttotal as! String
        }
        return ""
    }
    
    class func SaveLastTotalReportSendDate(_ date :String) {
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(date, forKey: "LastTotalReportSendDate")
        kUserDefault.synchronize()
    }
    class func Host(_ host :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(host, forKey: "SMTPFromHost")
        kUserDefault.synchronize()
    }
    class func Host() -> String{
        let kUserDefault = UserDefaults.standard
        if let host = kUserDefault.value(forKey: "SMTPFromHost")  {
            return host as! String
        }
        return ""
    }
    class func UseSSL(_ ssl :Bool){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(ssl, forKey: "SMTPSSL")
        kUserDefault.synchronize()
    }
    class func UseSSl() -> Bool{
        let kUserDefault = UserDefaults.standard
        if let ssl = kUserDefault.value(forKey: "SMTPSSL")  {
            return ssl as! Bool
        }
        return false
        
        
    }
    class func UseLogin(_ login :Bool){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(login, forKey: "SMTPUserLogin")
        kUserDefault.synchronize()
    }
    class func UseLogin() -> Bool{
        let kUserDefault = UserDefaults.standard
        if let login = kUserDefault.value(forKey: "SMTPUserLogin")  {
            return login as! Bool
        }
        return false
    }
    
    
    
    class func LoginUserName(_ userName :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(userName, forKey: "SMTPUserName")
        kUserDefault.synchronize()
    }
    class func LoginUserName() -> String{
        let kUserDefault = UserDefaults.standard
        if let username = kUserDefault.value(forKey: "SMTPUserName")  {
            return username as! String
        }
        return ""
        
    }
    
    class func LoginPassword(_ password :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(password, forKey: "SMTPUserPassword")
        kUserDefault.synchronize()
    }
    class func LoginPassword() -> String{
        let kUserDefault = UserDefaults.standard
        if let pass = kUserDefault.value(forKey: "SMTPUserPassword")  {
            return pass as! String
        }
        return ""
    }
    
    class func FromEmail(_ fromEmail :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(fromEmail, forKey: "SMTPFromEmailAddress")
        kUserDefault.synchronize()
    }
    class func FromEmail() -> String{
        let kUserDefault = UserDefaults.standard
        if let bcc = kUserDefault.value(forKey: "SMTPFromEmailAddress")  {
            return bcc as! String
        }
        return ""
    }
    
    class func CC_Email(_ ccEmail :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(ccEmail, forKey: "CC_EmailAddress")
        kUserDefault.synchronize()
    }
    class func CC_Email() -> String{
        let kUserDefault = UserDefaults.standard
        if let bcc = kUserDefault.value(forKey: "CC_EmailAddress")  {
            return bcc as! String
        }
        return ""
    }
    
    class func BCC_Email(_ bccEmail :String){
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(bccEmail, forKey: "BCC_EmailAddress")
        kUserDefault.synchronize()
    }
    class func BCC_Email() -> String{
        let kUserDefault = UserDefaults.standard
        
        if let bcc = kUserDefault.value(forKey: "BCC_EmailAddress")  {
            return bcc as! String
        }
        return ""
        
    }
    
    
    class func AppCurrentTime() -> NSDate {
        let sourceDate = NSDate()
        let sourceTimeZone = NSTimeZone.init(name: "GMT")!
        let destinationTimeZone = NSTimeZone.system
        let sourceGMTOffset = sourceTimeZone.secondsFromGMT(for: sourceDate as Date)
        let destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: sourceDate as Date)
        let interval = destinationGMTOffset - sourceGMTOffset
        return NSDate.init(timeInterval: TimeInterval(interval), since: sourceDate as Date)
    }
    
    class func AppTimeZone() -> NSTimeZone{
        return NSTimeZone.init(name: "GMT")!
    }
    
    
    
}
