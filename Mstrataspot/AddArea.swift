//
//  AddArea.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class AddArea: UIViewController {

    
    
    @IBOutlet weak var txtAreaName: UITextField!
    var sectionManageobj : NSManagedObject!
    var areaManageobj : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if areaManageobj != nil {
            txtAreaName.text = areaManageobj.value(forKey: "name") as! String
        }
        
        
    }

    
    
    
    @IBAction func saveArea(_ sender: Any) {
        
        guard
            let name = txtAreaName.text, !name.isEmpty
            else {
                
                
                let alert = UIAlertController(title: "Alert", message: "Please enter a section name.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntityAreas, in: context)
        if areaManageobj != nil {
            
            
            areaManageobj.setValue(name, forKey: "name")
            areaManageobj.setValue(sectionManageobj, forKey: "sections")//set Reelationship
            
            do {
                try areaManageobj.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Error occured during save entity")
            }
        }else{
        
        let area = NSManagedObject(entity: entityDescription!, insertInto: context)
        area.setValue(name, forKey: "name")
        area.setValue(sectionManageobj, forKey: "sections")//set Reelationship
        
            do {
                try area.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
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

extension AddArea: UITextFieldDelegate {

}
