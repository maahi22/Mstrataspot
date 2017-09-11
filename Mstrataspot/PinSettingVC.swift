//
//  PinSettingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/6/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class PinSettingVC: UIViewController {

    
    @IBOutlet weak var viewEditPin: UIView!
    @IBOutlet weak var txtCurrentPin: UITextField!
    @IBOutlet weak var txtPIN: UITextField!
    @IBOutlet weak var txtReenterPIN: UITextField!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var viewForgetPin: UIView!
    
    
    
    @IBOutlet weak var txtPinAnswer: UITextField!
    @IBOutlet weak var lblPinQuestion: UILabel!
    
    var editStatus : Bool = false
    var PinManageobj : NSManagedObject!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if editStatus {
            viewEditPin.isHidden = false
            viewForgetPin.isHidden = true
            rightBarButton.title = "Save"
            
        }else{
            viewEditPin.isHidden = true
            viewForgetPin.isHidden = false
            rightBarButton.title = "Go"
            
            
            
            lblPinQuestion.text = PinManageobj.value(forKey: "secretQuestion") as! String
            
        }
    }

    
    
    
    
    @IBAction func savePinData(_ sender: Any) {
        
        if rightBarButton.title == "Go"{
            
            guard
            let answer = txtPinAnswer.text, !answer.isEmpty
                else {
                    
                    
                    let alert = UIAlertController(title: "Alert", message: "Please enter answer", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
    
                    txtPinAnswer.resignFirstResponder()
                    
                    return
            }
            
            var pinAnswer = ""
            if let pinAns = PinManageobj.value(forKey: "secretAnswer"){
                pinAnswer = pinAns as! String
            }
            
            if answer != pinAnswer{
                let alert = UIAlertController(title: "Error!", message: "Secret answer is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                
                
                
             //   success send mail  //https://github.com/PerfectlySoft/Perfect-SMTP
            }
            
            
            
            
            
            
            
            
        }else if rightBarButton.title == "Save"{
            
            guard
                let oldPin = txtCurrentPin.text, !oldPin.isEmpty,
                let newPin = txtPIN.text, !newPin.isEmpty,
                let newConfirmPin = txtReenterPIN.text, !newConfirmPin.isEmpty
                else {
                    
                    
                    let alert = UIAlertController(title: "Alert", message: "Please fill all mendatory fields", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    txtCurrentPin.resignFirstResponder()
                    txtPIN.resignFirstResponder()
                    txtReenterPIN.resignFirstResponder()
                    return
            }
            
            var pin = ""
            if let pinNum = PinManageobj.value(forKey: "pin"){
                pin = pinNum as! String
            }
            
            
            
            if oldPin != pin {
               
                let alert = UIAlertController(title: "Error", message: "You have entered Wrong pin", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
            if newPin != newConfirmPin {
                
                let alert = UIAlertController(title: "Error", message: "PINs do not match. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
            
            if PinManageobj != nil{
                
                PinManageobj.setValue(newPin, forKey: "pin")
                
                do {
                    try PinManageobj.managedObjectContext?.save()
                    
                    let alert = UIAlertController(title: "Alert", message: "Pin update succesfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } catch {
                    print("Error occured during save entity")
                }
                
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

/*class PinSettingVC:UITextFieldDelegate {

    
}*/
