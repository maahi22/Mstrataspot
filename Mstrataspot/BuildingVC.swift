//
//  BuildingVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/6/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class BuildingVC: UIViewController {

    
    
    
    @IBOutlet weak var anyDayheightConstraint: NSLayoutConstraint!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
