//
//  MailSettingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class MailSettingVC: UIViewController {

    
    @IBOutlet weak var viewMailSetting: UIView!
    @IBOutlet weak var txtTomail: UITextField!
    @IBOutlet weak var txtCC: UITextField!
    @IBOutlet weak var txtBCC: UITextField!
    
    
    @IBOutlet weak var viewBackUpRestore: UIView!
    
    
    
     @IBOutlet weak var viewPinOption: UIView!
    
    @IBOutlet weak var viewImageSavingOption: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
