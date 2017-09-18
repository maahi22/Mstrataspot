//
//  Note.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/18/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class Note: UIDocument {
    
    var noteContent:String = ""
    
    class func loadFromContents (_ contents: String ,typeName:String )-> Bool{
    
    
    
    return true
    }
    
    
   /* class func contentsForType (_ typeName:String )-> NSData{
        
        if noteContent == "" {
            noteContent = "Empty"
        }
        
        if let newData = noteContent.data(using: String.Encoding.utf8){
           return newData
        }
        
    }
    */
}
