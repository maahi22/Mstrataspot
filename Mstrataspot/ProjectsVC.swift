//
//  ProjectsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class ProjectsVC: UIViewController,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var projectSegmentControl: UISegmentedControl!
    @IBOutlet weak var projectlistTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblNoRecords: UILabel!
    
     var selectedObj = NSManagedObject()
    var fetchedResultsController: NSFetchedResultsController<Projects>!
    
    func configureFetchedResultsController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let projectFetchRequest = NSFetchRequest<Projects>(entityName: "Projects")
        let primarySortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        //let secondarySortDescriptor = NSSortDescriptor(key: "commonName", ascending: true)
        projectFetchRequest.sortDescriptors = [primarySortDescriptor]
        projectFetchRequest.returnsObjectsAsFaults = false
        
        
        self.fetchedResultsController = NSFetchedResultsController<Projects>(
            fetchRequest: projectFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: "creationDate",
            cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
    }
   
    
    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        projectlistTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .insert:
            projectlistTableView.insertRows(at: [newIndexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .delete:
            projectlistTableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        case .update: break
        // update cell at indexPath
        case .move:
            projectlistTableView.deleteRows(at: [indexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
            projectlistTableView.insertRows(at: [newIndexPath! as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        projectlistTableView.endUpdates()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.loadData()
        
        
        
        
    }

    
    func loadData()  {
        configureFetchedResultsController()
        
        do {
            try fetchedResultsController.performFetch()
            
            projectlistTableView.reloadData()
            
        } catch {
            print("An error occurred")
            
        }
    }
    
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.newProjectStatus {
            self.performSegue(withIdentifier: "toNewProject", sender: self)
            appDelegate.newProjectStatus = false
        }
        
        
    }
    
    
    
    
    
    @IBAction func segmentValueChange(_ sender: Any) {
        
        
        
        
    }
    
    
    
    
    
    @IBAction func newProjects(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toNewProject", sender: self)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProjectdetails" {
            let nextScene =  segue.destination as! IssueListVC
            // Pass the selected object to the new view controller.
            nextScene.projectManageobj = self.selectedObj
            

        }
    }
    

}

/*extension ProjectsVC: NSFetchedResultsControllerDelegate {
    
}*/

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
   
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
        
        self.performSegue(withIdentifier: "toProjectdetails", sender: self)
        
        
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
