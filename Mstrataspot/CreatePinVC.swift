//
//  CreatePinVC.swift
//  Mstrataspot
//
//  Created by Maahi on 12/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class CreatePinVC: UIViewController {

    
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var txtConfirmPin: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var txtAnswer: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func savePin(_ sender: Any) {
        
        guard
        let pin = txtPin.text, !pin.isEmpty,
        let confirmpin = txtConfirmPin.text, !confirmpin.isEmpty,
        let email = txtEmail.text, !email.isEmpty,
        let question = txtQuestion.text, !question.isEmpty,
        let answer = txtAnswer.text, !answer.isEmpty
        
        else {
            
            if txtPin.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Please enter a PIN. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else if txtConfirmPin.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Please enter a PIN. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else if txtEmail.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Please enter a email.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else if txtQuestion.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Please enter a secret question..", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else if txtAnswer.text == "" {
                let alert = UIAlertController(title: "Alert", message: "Please enter a secret answer.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            
            
            
                let alert = UIAlertController(title: "Alert", message: "Please enter mendatory fields ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        

        
        if pin != confirmpin {
            
            let alert = UIAlertController(title: "Alert", message: "PINs do not match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        
        if !Validations.isValidEmail(email){
            
            let alert = UIAlertController(title: "Alert", message: "Please enter a valid email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntityPINSetting, in: context)
        
        let pinSettings = NSManagedObject(entity: entityDescription!, insertInto: context)
        // building.setValue(BMName, forKey: "title")
        pinSettings.setValue(pin, forKey: "pin")
        pinSettings.setValue(email, forKey: "email")
        pinSettings.setValue(question, forKey: "secretQuestion")
        pinSettings.setValue(answer, forKey: "secretAnswer")
        
        do {
            try pinSettings.managedObjectContext?.save()
            
            let alert = UIAlertController(title: "Alert", message: "Information save succesfully", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
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
