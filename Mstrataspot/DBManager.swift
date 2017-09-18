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
                var sections = (inspection.sections?.allObjects as! NSArray).sortedArray(using: sortDescriptors)
              
                
                
                if sections.count > 0 {
                    
                    for i in 0...(sections.count-1){
                        
                     let   section :Sections = sections[i] as! Sections
                        content = "\(content)<Section>"
                        var name = ""
                        if let name1 = section.name{
                            name = name1
                        }
                        content = "\(content)<Name>\(name)</Name>"
                        var gps = ""
                        if let name1 = section.gpsLocation{
                            gps = name1
                        }
                        content = "\(content)<GPSLocation>\(gps)</GPSLocation>"
                        var qrCode = ""
                        if let name1 = section.qrCode{
                            qrCode = name1
                        }
                        content = "\(content)<QRCode>\(qrCode)</QRCode>"
                        

                        content = "\(content)<Areas>"
                        
                      let  areas = (section.areas?.allObjects as! NSArray)
                        if areas.count > 0 {
                            
                            for i in 0...(areas.count-1){
                               let   area :Areas = areas[i] as! Areas
                                
                                content = "\(content)<Area>"
                                var name = ""
                                if let name1 = area.name{
                                    name = name1
                                }
                                content = "\(content)<Name>\(name)</Name>"
                                var loc = ""
                                if let name1 = section.gpsLocation{
                                    loc = name1
                                }
                                content = "\(content)<GPSLocation>\(loc)</GPSLocation>"
                                content = "\(content)<Reports>"
                                
                                
                                let  reports = (area.areasReport?.allObjects as! NSArray)
                                
                                if reports.count > 0 {
                                    
                                    for i in 0...(reports.count-1){
                                        let   report :AreasReport = reports[i] as! AreasReport
                                        
                                        content = "\(content)<Report>"
                                        var comment = ""
                                        if let name1 = report.comment{
                                            comment = name1
                                        }
                                        content = "\(content)<Comment>\(comment)</Comment>"
                                        
                                        if let date = report.date{
                                            content = "\(content)<Date>\(date)</Date>"
                                        }else{
                                            content = "\(content)<Date></Date>"
                                        }
                                        
                                        var location = ""
                                        if let name1 = report.geoLocation{
                                            location = name1
                                        }
                                        content = "\(content)<GEOLocation>\(location)</GEOLocation>"
                                        content = "\(content)<Ok>\(report.isOk)</Ok>"
                                        
                                        if let date = report.reportDate{
                                            content = "\(content)<ReportDate>\(date)</ReportDate>"
                                        }else{
                                            content = "\(content)<ReportDate></ReportDate>"
                                        }
                                        
                                        content = "\(content)</Report>"
                                        
                                    }
                                }
                                
                                content = "\(content)</Reports>"
                                content = "\(content)</Area>"
                                
                                
                                
                                
                            }
                        }
                        
                        content = "\(content)</Areas>"
                        content = "\(content)</Section>"
                        
                    }
                }
                
                
                content = "\(content)</Sections></RoutineInspection>"
                
                
            }
            
        }
        
        content = "\(content)</RoutineInspections></DataBase>"
        
        content = content.replacingOccurrences(of: "&", with: "*and*")
        
        return content
    }
    
    
    class func DeleteAllRoutineInspection(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
    
        var inspections:[NSManagedObject] = self.GetAllRoutineInspections()
        if inspections.count > 0 {
            
            for i in 0...(inspections.count-1){
                
                let inspection :RoutineInspections = inspections[i] as! RoutineInspections
                let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                let sortDescriptors = [sortDescriptor]
                var sections = (inspection.sections?.allObjects as! NSArray).sortedArray(using: sortDescriptors)
                
                if sections.count > 0 {
                    for i in 0...(sections.count-1){
                         let   section :Sections = sections[i] as! Sections
                        let  areas = (section.areas?.allObjects as! NSArray)
                        if areas.count > 0 {
                            
                            for i in 0...(areas.count-1){
                                let   area :Areas = areas[i] as! Areas
                                
                                let  reports = (area.areasReport?.allObjects as! NSArray)
                                if reports.count > 0 {
                                    
                                    for i in 0...(reports.count-1){
                                        let   report :AreasReport = reports[i] as! AreasReport
                                        
                                       context.delete(report)
                                        
                                    }
                                }
                                
                                context.delete(area)
                            }
                        }
                        
                        context.delete(section)
                        
                    }
                    
                }
                
                 context.delete(inspection)
            }
        }
        
        
    }
    
    class func GetPin() {
        
        
    }
    
}
