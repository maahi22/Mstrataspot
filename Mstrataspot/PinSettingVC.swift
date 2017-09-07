//
//  PinSettingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/6/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class PinSettingVC: UIViewController {

    
    @IBOutlet weak var viewEditPin: UIView!
    @IBOutlet weak var txtCurrentPin: UITextField!
    @IBOutlet weak var txtPIN: UITextField!
    @IBOutlet weak var txtReenterPIN: UITextField!
    
    @IBOutlet weak var viewForgetPin: UIView!
    @IBOutlet weak var txtPinAnswer: UITextField!
    @IBOutlet weak var lblPinQuestion: UILabel!
    
    var editStatus : Bool = false
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
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
