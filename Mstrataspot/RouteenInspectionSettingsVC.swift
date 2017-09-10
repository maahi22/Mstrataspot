//
//  RouteenInspectionSettingsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/6/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class RouteenInspectionSettingsVC: UIViewController {

    
    @IBOutlet weak var InspectionTableView: UITableView!
    var InspectionsObj = NSManagedObject()
    
    
    
     private let persistentContainer = NSPersistentContainer(name: "RoutineInspections")
    
    // MARK: -
   /* fileprivate lazy  var fetchedResultsController: NSFetchedResultsController<CompanyInfo>  = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<CompanyInfo> = CompanyInfo.fetchRequest()//NSFetchRequest(entityName: kEntityCompanyInfo)
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "companyName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()*/
    
    
    
   /* fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Projects> = {
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()*/
    
    // MARK: - View Life Cycle
    
    
    
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<RoutineInspections> = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        let fetchRequest = NSFetchRequest<RoutineInspections>(entityName: "RoutineInspections")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchedResultsController.performFetch()
        fetchedResultsController.delegate = self
        if let quotes = fetchedResultsController.fetchedObjects {
            if quotes.count > 0 {
                print(quotes.count)
            }
        }
        return fetchedResultsController
    }()
    
    
    // MARK: - NSFetchedResultsController delegate methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)  {
        InspectionTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)  {
        InspectionTableView.reloadData()
    }
    
    
    
    
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
        
        InspectionTableView.isHidden = !hasQuotes
        //projectSegmentControl.isHidden = !hasQuotes
       // lblNoRecords.isHidden = hasQuotes
        
       // activityIndicatorView.stopAnimating()
    }
    
    // MARK: -
    private func setupMessageLabel() {
       // lblNoRecords.text = "You don't have any projects."
    }
    
    
    
    
    
    
    
    @IBAction func NewBuilding(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toNewBuilding", sender: self)
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toBuildingList" {
            let nextScene =  segue.destination as! BuildingList
            nextScene.inspectionManageobj = self.InspectionsObj
            
            
           
            
        }
        
        
        
        
        
    }
    

}

extension RouteenInspectionSettingsVC: NSFetchedResultsControllerDelegate {
    
}


extension RouteenInspectionSettingsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 2.0
        }else{
            
            return 20.0
        }
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let Inspections = fetchedResultsController.fetchedObjects else { return 0 }
        return Inspections.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
       /* guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectListCell.reuseIdentifier, for: //indexPath) as? ProjectListCell else {
            fatalError("Unexpected Index Path")
        }*/
        
        // Fetch Quote
        let Inspections = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = Inspections.name
        cell.detailTextLabel?.text = Inspections.category
       // print(Projects.title)
        
        
        
        
        
       // cell.textLabel?.text = "text"
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        InspectionsObj = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "toBuildingList", sender: self)
        
        
    }
    
    
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        
        
        let   deleteObj = fetchedResultsController.object(at: indexPath)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let alertController = UIAlertController(title: "Delete!", message: "Are you sure", preferredStyle: UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            
            context.delete(deleteObj)
            //save the context
            do {
                try context.save()
                print("saved!")
                self.InspectionTableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
                        //pop
           // self.navigationController?.popViewController(animated: true)
        }
        
        let NoAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
            
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(NoAction)
        self.present(alertController, animated: true, completion: nil)
        

        
        
        
        
       
        
    }
    
}
