//
//  MailSettingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class MailSettingVC: UIViewController {

    @IBOutlet weak var viewImageSavingOption: UIView!
    @IBOutlet weak var viewMailSetting: UIView!
    @IBOutlet weak var txtTomail: UITextField!
    @IBOutlet weak var txtCC: UITextField!
    @IBOutlet weak var txtBCC: UITextField!
    
    @IBOutlet weak var viewBackUpRestore: UIView!
    @IBOutlet weak var createPinView: UIView!
    @IBOutlet weak var existingPINView: UIView!
    @IBOutlet weak var viewPinOption: UIView!
    
   var list: NSManagedObject? = nil
    @IBOutlet weak var mailSaveBarButton: UIBarButtonItem!
    
    var status = 0 //0 - mail setting 1- pin setting  2- backup restore 3- imagesaving
    var editPinSts : Bool = false
    
    
    
    
   private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
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
    
    
   private func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject?
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewMailSetting.isHidden = false
        viewBackUpRestore.isHidden = true
        viewImageSavingOption.isHidden = true
        viewPinOption.isHidden = true
        
        if  status == 1 {
            viewMailSetting.isHidden = true
            viewBackUpRestore.isHidden = true
            viewImageSavingOption.isHidden = true
            viewPinOption.isHidden = false
            
       //     check
            
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            let lists = self.fetchRecordsForEntity("PINSetting", inManagedObjectContext: context)
            
            if let listRecord = lists.first {
                list = listRecord
            } /*else if let listRecord = self.createRecordForEntity("PINSetting", inManagedObjectContext: context) {
                list = listRecord
            }*/
            
            if list != nil {
                createPinView.isHidden = true
                existingPINView.isHidden = false
                
            }else{
                createPinView.isHidden = false
                existingPINView.isHidden = true
                
            }
            
            
            
            
            self.navigationItem.rightBarButtonItem = nil
            
            
        }else if status == 2 {
            viewMailSetting.isHidden = true
            viewBackUpRestore.isHidden = false
            viewImageSavingOption.isHidden = true
            viewPinOption.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
        }else if status == 3 {
            viewMailSetting.isHidden = true
            viewBackUpRestore.isHidden = true
            viewImageSavingOption.isHidden = false
            viewPinOption.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
        }else{
            self.navigationItem.rightBarButtonItem = mailSaveBarButton
            viewMailSetting.isHidden = false
            viewBackUpRestore.isHidden = true
            viewImageSavingOption.isHidden = true
            viewPinOption.isHidden = true
            
        }
        
        
    }
    
    
    
    
    
    
    
    @IBAction func createPin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toCreatePin", sender: self)
    }
    
    
    
    
    
    @IBAction func ImageSaveSwitch(_ sender: Any) {
        
        
        
    }
    
    
    
    
    @IBAction func EditPinClicked(_ sender: Any) {
        editPinSts = true
        self.performSegue(withIdentifier: "toEditPin", sender: self)
        
        
    }
    
    
    
    @IBAction func forgetPinClicked(_ sender: Any) {
         editPinSts = false
        self.performSegue(withIdentifier: "toEditPin", sender: self)
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditPin" {
            let nextScene =  segue.destination as! PinSettingVC
            nextScene.editStatus = self.editPinSts
            nextScene.PinManageobj = list
        }
        
        
    }
    

}
