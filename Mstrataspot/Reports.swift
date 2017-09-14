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
    
    var selectedObj = NSManagedObject()
    
    
    private let persistentContainer = NSPersistentContainer(name: "Projects")
    
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Projects> = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        let fetchRequest = NSFetchRequest<Projects>(entityName: "Projects")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchedResultsController.performFetch()
        fetchedResultsController.delegate = self
        if let Projects = fetchedResultsController.fetchedObjects {
            if Projects.count > 0 {
                print(Projects.count)
            }
        }
        return fetchedResultsController
    }()
    // MARK: - View Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
    }

    
    
    // MARK: - View Methods
    
    private func setupView() {
        setupMessageLabel()
        
        updateView()
    }
    
    private func updateView() {
        var hasQuotes = false
        
        if let projects1 = fetchedResultsController.fetchedObjects {
            hasQuotes = projects1.count > 0
        }
        
        reportTableView.isHidden = !hasQuotes
        //projectSegmentControl.isHidden = !hasQuotes
       // lblNoRecords.isHidden = hasQuotes
        
       // activityIndicatorView.stopAnimating()
    }
    
    // MARK: -
    private func setupMessageLabel() {
        //lblNoRecords.text = "You don't have any projects."
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReportsDetails" {
            let nextScene =  segue.destination as! ReportsDetailsVC
            // Pass the selected object to the new view controller.
            nextScene.detailProjectManageobj = self.selectedObj
        }
    }
    

}

extension Reports: NSFetchedResultsControllerDelegate {
    
}

extension Reports: UITableViewDelegate, UITableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // guard let Projects = fetchedResultsController.fetchedObjects else { return 0 }
        //return Projects.count
        
        guard let Projects = fetchedResultsController.fetchedObjects else { return 0 }
        return Projects.count
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectListCell.reuseIdentifier, for: indexPath) as? ProjectListCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let Projects = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.lblTitle.text = Projects.title
        cell.lblDescription.text = Projects.project_description
        if  Projects.value(forKey: "projectLogoImage") != nil{
            cell.imgView.image =  UIImage(data:Projects.value(forKey: "projectLogoImage") as! Data,scale:1.0)
        }
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       selectedObj = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "toReportsDetails", sender: self)
        
        
    }
    
    
    
}
