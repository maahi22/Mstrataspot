//
//  FilesMethods.swift
//  MyDunia
//
//  Created by Rajeev kumar singh on 8/1/17.
//  Copyright © 2017 TalentTrobe(India.com. All rights reserved.
//

import UIKit

class FilesMethods: NSObject {

    
        
    class func getImageFromDocDir(_ fileName: String , completion:@escaping ( _ image :UIImage , _ Status:Bool) -> Void ){
            
            let fileManager = FileManager.default
            let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(fileName)
            if fileManager.fileExists(atPath: imagePAth){
                let img = UIImage(contentsOfFile: imagePAth)
                completion(img!, true)
                
            }else{
                print("No Image")
                completion(UIImage(), false)
            }
            
        }
        
    
        
        //Save Image At Document Directory :
        
        class func saveImageDocumentDirectory(_ name :String , imageData: NSData){
            
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
            
            fileManager.createFile(atPath: paths as String, contents: imageData as Data, attributes: nil)
        }
        
    class func deleteImageDocumentDirectory(_ name :String ){
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }
        

    }
    
    
    
    
    
        //Get Document Directory Path :
        class func getDirectoryPath() -> String {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
        
        // Create Directory :
       class func createDirectory(_ dirName: String){
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(dirName)
            if !fileManager.fileExists(atPath: paths){
                try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
            }else{
                print("Already dictionary created.")
            }
        }
        
        //Delete Directory :
        func deleteDirectory(_ dirName: String){
            let fileManager = FileManager.default
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(dirName)
            if fileManager.fileExists(atPath: paths){
                try! fileManager.removeItem(atPath: paths)
            }else{
                print("Something wronge.")
            }
        }
    
    
    
    
    //Save lat long
    
    class func saveLastUpdatelatitude(_ lat: Double , lng :Double){
        
        if lat == 0.0 || lng == 0.0 {
            return
        }
        
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(lat, forKey: "lat")
        kUserDefault.set(lng, forKey: "lang")
        kUserDefault.synchronize()
    }
    
    
    
    
    
    
    
    //Extra methods
    
    
    class func RemoveAllCSV(){
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let csvFiles = directoryContents.filter{ $0.pathExtension == "csv" }
            print("Csv urls:",csvFiles)
            let csvFileNames = csvFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("Csv list:", csvFileNames)
            
            for name in csvFileNames{
                self.removeItem(name)
            }
            
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    class func RemoveAlldoc(){
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let docFiles = directoryContents.filter{ $0.pathExtension == "doc" }
            print("doc urls:",docFiles)
            let docFileNames = docFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("doc list:", docFileNames)
            
            for name in docFileNames{
                self.removeItem(name)
            }
            
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    
    class func RemoveAllPDf(){
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let pdfFiles = directoryContents.filter{ $0.pathExtension == "pdf" }
            print("pdf urls:",pdfFiles)
            let pdfFileNames = pdfFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("pdf list:", pdfFileNames)
            
            for name in pdfFileNames{
                self.removeItem(name)
            }
            
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        

        
    }
    
    
    class func removeItem(_ filename:String){
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
        if fileManager.fileExists(atPath: paths){
            try! fileManager.removeItem(atPath: paths)
        }
    }
    
    
    
    
    
    
    
    
    
    
    //Image methods
    class func loadImage (_ imageName :String)-> UIImage{
        
        let fullPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        return UIImage.init(contentsOfFile: fullPath)!
    }
    
    
    class func saveImage(_ image: UIImage) -> String{
        let now  = DefaultDataManager.AppCurrentTime()
        let name = "Local_\(self.GetUUID)_\(now).png"
        
        self.saveImageDocumentDirectory(name, imageData: (UIImagePNGRepresentation(image) as NSData?)!)
        
        return name
        
        
    }
    
    class func GetUUID() -> String {
        let uuid = UUID().uuidString
        return uuid
    }
    
    
    
    
}
