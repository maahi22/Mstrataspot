//
//  HomeVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Logo"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 134, height: 30)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
    }

    
    
    
    @IBAction func CreateBMSProject(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 1
        
        
    }
    
    
    
    
    
    @IBAction func ShowRoutineInspectionList(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 1
        
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
