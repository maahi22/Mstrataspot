//
//  RestoreFromXML.swift
//  Mstrataspot
//
//  Created by Maahi on 09/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit


class RestoreFromXML: UIViewController {

    @IBOutlet weak var txtViewXML: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtViewXML.layer.borderColor = UIColor.black.cgColor
        txtViewXML.layer.borderWidth = 1
    }

    
    
    
    
    
    
    @IBAction func RestoreClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to restore this?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            
           
            
            let alert = UIAlertController(title: "Error", message: "This is not a valid XML!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
            
            
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { action in
            
        }))

        
        self.present(alert, animated: true, completion: nil)
        
        
        
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
