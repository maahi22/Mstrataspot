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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntitySections, in: context)
        
        
        let sections = NSManagedObject(entity: entityDescription!, insertInto: context)
        // building.setValue(BMName, forKey: "title")
        sections.setValue(name, forKey: "name")
      //  sections.setValue(qrCode, forKey: "qrCode")
      //  sections.setValue(gpsloc, forKey: "gpsLocation")
        sections.setValue(inspectionManageobj, forKey: "routineInspection")//set Reelationship
        
        
        
        do {
            try sections.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Error occured during save entity")
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
