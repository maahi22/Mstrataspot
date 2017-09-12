//
//  LevelVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class LevelVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblGPSLocation: UILabel!
    @IBOutlet weak var lblQACode: UILabel!
    
    
   var inspectionManageobj : NSManagedObject!
   var sectionManageobj : NSManagedObject!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if sectionManageobj != nil {
            
            if let name = sectionManageobj.value(forKey: "name"){
                
                self.txtName.text = name as? String
            }
            
            if let gps = sectionManageobj.value(forKey: "gpsLocation"){
                
                self.lblGPSLocation.text = gps as? String
            }
            
            
            if let qrCode = sectionManageobj.value(forKey: "qrCode"){
                
                self.lblQACode.text = qrCode as? String
            }
            
            
            /*self.txtName.text = sectionManageobj.value(forKey: "name") as! String
            self.lblGPSLocation.text = sectionManageobj.value(forKey: "gpsLocation") as! String
            self.lblQACode.text = sectionManageobj.value(forKey: "qrCode") as! String*/
            
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func scaneCode(_ sender: Any) {
        
        
        
    }
    
    
    
    @IBAction func scanLocation(_ sender: Any) {
        
        
        
    }
    
    
    
    
    @IBAction func saveSection(_ sender: Any) {
        
        
      
        
        
        
        guard
            let name = txtName.text, !name.isEmpty
            else {
                
                
                let alert = UIAlertController(title: "Alert", message: "Please enter a section name.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
       /* guard
            let gpsloc = lblGPSLocation.text, !gpsloc.isEmpty
            else {
                let alert = UIAlertController(title: "Error", message: "Please enter a GPS location.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        
        guard
            let qrCode = lblQACode.text, !qrCode.isEmpty
            else {
                let alert = UIAlertController(title: "Error", message: "Please scan a valid QR code.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        */
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        if sectionManageobj != nil {
            
           
            // building.setValue(BMName, forKey: "title")
            sectionManageobj.setValue(name, forKey: "name")
            //  sectionManageobj.setValue(qrCode, forKey: "qrCode")
            //  sectionManageobj.setValue(gpsloc, forKey: "gpsLocation")
            //sectionManageobj.setValue(inspectionManageobj, forKey: "routineInspection")//set Reelationship
            
            do {
                try sectionManageobj.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Information update succesfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("Error occured during save entity")
            }
            
            
            
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntitySections, in: context)
            let sections = NSManagedObject(entity: entityDescription!, insertInto: context)
            // building.setValue(BMName, forKey: "title")
            sections.setValue(name, forKey: "name")
            //  sections.setValue(qrCode, forKey: "qrCode")
            //  sections.setValue(gpsloc, forKey: "gpsLocation")
            sections.setValue(inspectionManageobj, forKey: "routineInspection")//set Reelationship
            
            do {
                try sections.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Information save succesfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("Error occured during save entity")
            }
        }
        
        
        
       
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
