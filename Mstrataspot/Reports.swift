//
//  Reports.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData

class Reports: UIViewController {

    
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var reportTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    
    
    @IBAction func segmentValueChange(_ sender: Any) {
        
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func SortBy(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        let btnSeverityAscending:UIAlertAction  = (UIAlertAction(title: "Project Name Ascending", style: .destructive, handler: { action in
            
            
            
            
            
        }))
        
        let btnSeverity:UIAlertAction  = (UIAlertAction(title: "Project Name Descending", style: .default, handler: { action in
            
            
            
        }))
        
        let btnDateAscending:UIAlertAction  = (UIAlertAction(title: "Date Ascending", style: .default, handler: { action in
            
            
            
        }))
        
        let btnDateDescending:UIAlertAction  = (UIAlertAction(title: "Date Descending", style: .default, handler: { action in
            
            
            
        }))
        
        let btnClientAscending:UIAlertAction  = (UIAlertAction(title: "Client Ascending", style: .default, handler: { action in
            
            
            
        }))
        
        let btnClientDescending:UIAlertAction  = (UIAlertAction(title: "Client Descending", style: .default, handler: { action in
            
            
            
        }))
        
        
        uiAlert.addAction(btnSeverityAscending)
        uiAlert.addAction(btnSeverity)
        uiAlert.addAction(btnDateAscending)
        uiAlert.addAction(btnDateDescending)
        uiAlert.addAction(btnClientAscending)
        uiAlert.addAction(btnClientDescending)
        
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))
        
        
        
        
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

extension Reports: NSFetchedResultsControllerDelegate {
    
}

extension Reports: UITableViewDelegate, UITableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // guard let Projects = fetchedResultsController.fetchedObjects else { return 0 }
        //return Projects.count
        
        return 5
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectListCell.reuseIdentifier, for: indexPath) as? ProjectListCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
      //  let Projects = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
     //   cell.lblTitle.text = Projects.title
     //   cell.lblDescription.text = Projects.description
        
        // Configure Cell
        //  cell.authorLabel.text = quote.author
        //  cell.contentsLabel.text = quote.contents
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "toReportsDetails", sender: self)
        
        
    }
    
    
    
}
