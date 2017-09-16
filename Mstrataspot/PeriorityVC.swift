//
//  PeriorityVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit


protocol PeriorityDelegate {
    
    func PeriorityClick(_ periority : UIColor)
}

class PeriorityVC: UIViewController {

    var delegate:PeriorityDelegate?
    var periorityColor  =  UIColor()
    
    
    
    
    
    @IBAction func periorityBtnClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            periorityColor = .red
        case 2:
            periorityColor = .yellow
        case 3:
            periorityColor = .green
        case 4:
            periorityColor = .blue
        default:
            break
        }
        
        delegate?.PeriorityClick(periorityColor)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
