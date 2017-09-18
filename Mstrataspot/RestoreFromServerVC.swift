//
//  RestoreFromServerVC.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/8/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class RestoreFromServerVC: UIViewController {

    
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    @IBAction func ResoreClicked(_ sender: Any) {
        
        if txtPhoneNumber.text == "" || !Validations.IsValidPhone(txtPhoneNumber.text!){
            
            let alert = UIAlertController(title: "Wrong", message: "Please enter a valid phone number.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            
            self.RestoreFromServer()
        }
        
        
        
        
        
    }
    
    
    
    func RestoreFromServer()  {
        
        var type = "xml"
        
        if ((NSClassFromString("NSJSONSerialization")) != nil){
            type = "json"
        }
        
        var stringUrl = ""
        if type == "xml" {
            
            if let phone = txtPhoneNumber.text , !phone.isEmpty {
                stringUrl = "\(stratspotBaseUrl)routine-inspections/\(phone)?type=xml"
            }
            
        }else{
            if let phone = txtPhoneNumber.text , !phone.isEmpty {
                stringUrl = "\(stratspotBaseUrl)routine-inspections/\(phone)?type=json"
            }
        }
        
        
        
       
        
        
        
        do {
            var content = try String(contentsOf:URL(string: stringUrl)!)
       
            var errorMessage = ""
        if content == ""{
            
            errorMessage = "Server does not response."
        }else if content == "Invalid phone number."{
            
            errorMessage = content
        }else{
            
            if type == "xml" {
                
                
                
            }else{
                
                
                
            }
            
            
            
            }
        
        
        
        }
        catch let error {
            // Error handling
            
            print(error)
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

extension RestoreFromServerVC:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtPhoneNumber {
            let charsLimit = 10
            let startingLength = textField.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            return newLength <= charsLimit
        }else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}
