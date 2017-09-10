//
//  BuildingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/6/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class BuildingVC: UIViewController {

    var inspectionManageobj : NSManagedObject!
    
    
    @IBOutlet weak var anyDayheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    
    
    @IBOutlet weak var cbIsWeekly: MICheckBox!
    @IBOutlet weak var cbIsDaily: MICheckBox!
    
     @IBOutlet weak var cbIsSunday: MICheckBox!
     @IBOutlet weak var cbIsMonday: MICheckBox!
     @IBOutlet weak var cbIsTuesday: MICheckBox!
     @IBOutlet weak var cbIsWednesday: MICheckBox!
     @IBOutlet weak var cbIsThusday: MICheckBox!
     @IBOutlet weak var cbIsFriday: MICheckBox!
     @IBOutlet weak var cbIsSaturday: MICheckBox!
     @IBOutlet weak var cbIsAnyDay: MICheckBox!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if inspectionManageobj != nil{
            
            self.loadInspection()
        }
        
        
        
        
        
    }

    
    
    
    func loadInspection() {
        
        //inspectionManageobj
        txtName.text = inspectionManageobj.value(forKey: "name") as! String
        txtCategory.text = inspectionManageobj.value(forKey: "category") as! String
        
    }
    
    
    
    
    @IBAction func radioButtonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            anyDayheightConstraint.constant = 0
        }else {
            anyDayheightConstraint.constant = 35
        }
        
        
    }
    
    
    
    
    
    
    @IBAction func selectDay(_ sender: UIButton) {
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func saveBuilding(_ sender: Any) {
        
        guard
            let name = txtName.text, !name.isEmpty,
            let category = txtCategory.text, !category.isEmpty
        
            
            else {
                
                
                let alert = UIAlertController(title: "Alert", message: "Please enter mendatory fields credential", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        
        
        //Save inside
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntityRoutineInspections, in: context)
        
        
        
        
        let RoutineInspection = NSManagedObject(entity: entityDescription!, insertInto: context)
        // building.setValue(BMName, forKey: "title")
        RoutineInspection.setValue(name, forKey: "name")
        RoutineInspection.setValue(category, forKey: "category")
        RoutineInspection.setValue(cbIsWeekly.isChecked, forKey: "isWeekly")
        RoutineInspection.setValue(cbIsAnyDay.isChecked, forKey: "isAnyDay")
        RoutineInspection.setValue(cbIsSunday.isChecked, forKey: "isSunday")
        RoutineInspection.setValue(cbIsSaturday.isChecked, forKey: "isSaturday")
        RoutineInspection.setValue(cbIsFriday.isChecked, forKey: "isFriday")
        RoutineInspection.setValue(cbIsThusday.isChecked, forKey: "isThusday")
        RoutineInspection.setValue(cbIsWednesday.isChecked, forKey: "isWednesday")
        RoutineInspection.setValue(cbIsThusday.isChecked, forKey: "isTuesday")
        RoutineInspection.setValue(cbIsMonday.isChecked, forKey: "isMonday")
        RoutineInspection.setValue(false, forKey: "isPublished")
        
        
        do {
            try RoutineInspection.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
            
        } catch {
            print("Error occured during save entity")
        }
        
        
        
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
