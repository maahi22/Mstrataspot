//
//  IssueListVC.swift
//  Mstrataspot
//
//  Created by Maahi on 16/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class IssueListVC: UIViewController {

    var projectManageobj : NSManagedObject!
    var selectedObj = NSManagedObject()
    var editStatus : Bool = false
    
    @IBOutlet weak var issueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if projectManageobj != nil {
            
            if let title = projectManageobj.value(forKey: "title"){
                self.title = title as? String
            }
            
        }
        
        self.loadData()
        
    }
    
    func loadData()  {
        configureFetchedResultsController()
        
        do {
            try fetchedResultsController.performFetch()
            
            issueTableView.reloadData()
            
        } catch {
            print("An error occurred")
            
        }
    }

    
    
    
    var fetchedResultsController: NSFetchedResultsController<Issues>!
    
    func configureFetchedResultsController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let issueFetchRequest = NSFetchRequest<Issues>(entityName: "Issues")
        let primarySortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        //let secondarySortDescriptor = NSSortDescriptor(key: "commonName", ascending: true)
        issueFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        issueFetchRequest.predicate = NSPredicate(format: "project = %@", self.projectManageobj)
        
        
        self.fetchedResultsController = NSFetchedResultsController<Issues>(
            fetchRequest: issueFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: "creationDate",
            cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        issueTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .insert:
            issueTableView.insertRows(at: [newIndexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .delete:
            issueTableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .update: break
        // update cell at indexPath
        case .move:
            issueTableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
            issueTableView.insertRows(at: [newIndexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        issueTableView.endUpdates()
    }
    
    @IBAction func EditProject(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toEditProject", sender: self)
    }
    
    
    
    
    @IBAction func AddIssue(_ sender: Any) {
        editStatus = false
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
            if editStatus {
                nextScene.issueManageobj = self.selectedObj
            }else{
                nextScene.issueManageobj = nil
            }
            
        }else if segue.identifier == "toEditProject" {
            let nextScene =  segue.destination as! NewProjectVC
            nextScene.editProjectManageobj = self.projectManageobj
            
        }
    }
    

}

extension IssueListVC: NSFetchedResultsControllerDelegate {
    
}

extension IssueListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 75.0
    }
    
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        
        return 0
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        
        
        // Fetch Quote
        let Issues = fetchedResultsController.object(at: indexPath)
        // Configure Cell
        if let title = Issues.title{
            cell.textLabel?.text = title
        }
        
        
        if let des = Issues.issue_description{
            cell.detailTextLabel?.text = des
        }
        
      // cell.detailTextLabel?.text = Issues.issue_description
        
        
        
        if  Issues.value(forKey: "issueImage") != nil{
            cell.imageView?.image =  UIImage(data:Issues.value(forKey: "issueImage") as! Data,scale:1.0)
        }
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        editStatus = true
        selectedObj = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "toAddIssue", sender: self)
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        /*if (commitEditBlock != nil) {
         commitEditBlock!(tableView, editingStyle, indexPath)
         }*/
    }
    
    
    
}
