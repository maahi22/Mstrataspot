//
//  ProjectsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class ProjectsVC: UIViewController {

    @IBOutlet weak var projectSegmentControl: UISegmentedControl!
    @IBOutlet weak var projectlistTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblNoRecords: UILabel!
    
    private var persistentContainer = NSPersistentContainer(name: "Projects")
   

    
   // private let persistentContainer = NSPersistentContainer(name: "Projects")
    
    // MARK: -
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Projects> = {
       
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
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
        
        projectlistTableView.isHidden = !hasQuotes
        //projectSegmentControl.isHidden = !hasQuotes
        lblNoRecords.isHidden = hasQuotes
        
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: -
    private func setupMessageLabel() {
        lblNoRecords.text = "You don't have any projects."
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProjectsVC: NSFetchedResultsControllerDelegate {
    
}

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
   
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        cell.lblDescription.text = Projects.description
        
        // Configure Cell
      //  cell.authorLabel.text = quote.author
      //  cell.contentsLabel.text = quote.contents
        
        return cell

        
        
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
