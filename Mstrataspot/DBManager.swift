//
//  DBManager.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/18/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {

    
    
    class func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    
    class func GetAllRoutineInspections() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let lists = self.fetchRecordsForEntity("RoutineInspections", inManagedObjectContext: context)
        
        return lists
    }
    
    
    class func GetXMLContentOfRoutineInspections() -> String{
        
        var content:String = "<DataBase><RoutineInspections>"
        var inspections:[NSManagedObject] = self.GetAllRoutineInspections()
        
        if inspections.count > 0 {
            
            for i in 0...(inspections.count-1){
                
                let inspection :RoutineInspections = inspections[i] as! RoutineInspections
                
                content = "\(content)<RoutineInspection>"
                var name = ""
                if let name1 = inspection.name{
                    name = name1
                }
                content = "\(content)<Name>\(name)</Name>"
                
                var category = ""
                if let cat = inspection.category{
                    category = cat
                }
                content = "\(content)<Category>\(category)</Category>"
                
                
                
                content = "\(content)<Friday>\(inspection.isFriday)</Friday>"
                content = "\(content)<Monday>\(inspection.isMonday)</Monday>"
                content = "\(content)<Saturday>\(inspection.isSaturday)</Saturday>"
                content = "\(content)<Sunday>\(inspection.isSunday)</Sunday>"
                content = "\(content)<Thursday>\(inspection.isThusday)</Thursday>"
                content = "\(content)<Tuesday>\(inspection.isTuesday)</Tuesday>"
                content = "\(content)<Wednesday>\(inspection.isWednesday)</Wednesday>"
                content = "\(content)<Published>\(inspection.isPublished)</Published>"
                content = "\(content)<AnyDay>\(inspection.isAnyDay)</AnyDay>"
                content = "\(content)<Weekly>\(inspection.isWeekly)</Weekly>"
                
                
                content = "\(content)<Sections>"
                
                let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                let sortDescriptors = [sortDescriptor]
              //  let sections = inspection.sections?.allObjects sort
                
                
                
            }
            
        }
        
        
        
        retrun content
    }
    
    
    class func DeleteAllRoutineInspection(){
        
        
    }
    
    class func GetPin() {
        
        
    }
    
}
