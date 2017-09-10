//
//  MailSettingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

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
    
   
    @IBOutlet weak var mailSaveBarButton: UIBarButtonItem!
    
    var status = 0 //0 - mail setting 1- pin setting  2- backup restore 3- imagesaving
    var editPinSts : Bool = false
    
    
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
            createPinView.isHidden = true
            existingPINView.isHidden = false
            
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
        self.performSegue(withIdentifier: "toEditPin", sender: self)
        editPinSts = true
        
    }
    
    
    
    @IBAction func forgetPinClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toEditPin", sender: self)
        editPinSts = false
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
            
        }
        
        
    }
    

}
