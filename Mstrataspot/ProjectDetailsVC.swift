//
//  ProjectDetailsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class ProjectDetailsVC: UIViewController {

    var projectManageobj : NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if projectManageobj != nil {
            
            if let title = projectManageobj.value(forKey: "title"){
                self.title = title as! String
            }
            
        }
        
    }

    
    
    
    
    @IBAction func EditProject(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toEditProject", sender: self)
    }
    
    
    
    
    @IBAction func AddIssue(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toAddIssue", sender: self)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddIssue" {
            let nextScene =  segue.destination as! IssueVC
            // Pass the selected object to the new view controller.
            nextScene.projectManageobj = self.projectManageobj
            
        }else if segue.identifier == "toEditProject" {
            let nextScene =  segue.destination as! NewProjectVC
            nextScene.editProjectManageobj = self.projectManageobj
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

}
