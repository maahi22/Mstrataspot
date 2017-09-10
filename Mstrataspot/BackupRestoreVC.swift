//
//  BackupRestoreVC.swift
//  Mstrataspot
//
//  Created by Maahi on 09/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class BackupRestoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @IBAction func Createbackup(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toCreatebackup", sender: self)
    }
    
    
    
    
    
    @IBAction func RestoreFromServer(_ sender: Any) {
        self.performSegue(withIdentifier: "toRestoreFromServer", sender: self)
        
    }
    
    
    
    @IBAction func RestoreFromXML(_ sender: Any) {
        self.performSegue(withIdentifier: "toRestoreFromXML", sender: self)
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
