//
//  ReportsDetailsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class ReportsDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func mailReportClicked(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "Mail report", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        let btnPrice:UIAlertAction  = (UIAlertAction(title: "Pdf", style: .destructive, handler: { action in
           
            
            
            
            
        }))
        
        let btnDistance:UIAlertAction  = (UIAlertAction(title: "Doc", style: .destructive, handler: { action in
            
            
            
            
            
        }))
        
        uiAlert.addAction(btnPrice)
        uiAlert.addAction(btnDistance)
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))

        
        
        
        
    }
    
    
    
    
    
    func mailPdf() {
        
        
    }
    
    
    
    
    
    
    func mailDocument() {
        
        
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
