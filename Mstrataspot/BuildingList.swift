//
//  BuildingList.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData

class BuildingList: UIViewController {//Section List

    
    
    @IBOutlet weak var buildingListTableView: UITableView!
    var inspectionManageobj : NSManagedObject!
   
    var sectionObj = NSManagedObject()
    
    
    private let persistentContainer = NSPersistentContainer(name: "Sections")
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Sections> = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        let fetchRequest = NSFetchRequest<Sections>(entityName: "Sections")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:context, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchedResultsController.performFetch()
        fetchedResultsController.delegate = self
        if let Sections = fetchedResultsController.fetchedObjects {
            if Sections.count > 0 {
                print(Sections.count)
            }
        }
        return fetchedResultsController
    }()
    
    // MARK: - NSFetchedResultsController delegate methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)  {
        buildingListTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)  {
        buildingListTableView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = inspectionManageobj.value(forKey: "name") as! String
        
        
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
        
        buildingListTableView.isHidden = !hasQuotes
        //projectSegmentControl.isHidden = !hasQuotes
        // lblNoRecords.isHidden = hasQuotes
        
        // activityIndicatorView.stopAnimating()
    }
    
    // MARK: -
    private func setupMessageLabel() {
        // lblNoRecords.text = "You don't have any projects."
    }
    

    
    
    
    
    
    
    
    
    
    
    @IBAction func EditClick(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toEditInspection", sender: self)
        
    }
    
    
    
    @IBAction func AddLevel(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toAddLeval", sender: self)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddLeval" {
            let nextScene =  segue.destination as! LevelVC
            // Pass the selected object to the new view controller.
            nextScene.inspectionManageobj = self.inspectionManageobj
            
        }else if segue.identifier == "toEditInspection" {
            let nextScene =  segue.destination as! BuildingVC
            // Pass the selected object to the new view controller.
            nextScene.inspectionManageobj = self.inspectionManageobj
            
        }else if segue.identifier == "toBuildingDetails" {
            let nextScene =  segue.destination as! BuildingDetails
            // Pass the selected object to the new view controller.
            nextScene.inspectionManageobj = self.inspectionManageobj
            nextScene.sectionManageobj = self.sectionObj
        }

        
        
        
        
    }
    

}


extension BuildingList: NSFetchedResultsControllerDelegate {
    
}


extension BuildingList : UITableViewDelegate, UITableViewDataSource{
    
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
        
        guard let section = fetchedResultsController.fetchedObjects else { return 0 }
        return section.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        /* guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectListCell.reuseIdentifier, for: //indexPath) as? ProjectListCell else {
         fatalError("Unexpected Index Path")
         }*/
        
        // Fetch Quote
        let section = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = section.name
        cell.detailTextLabel?.text = section.qrCode
        // print(Projects.title)
        
        
        
        
        
        // cell.textLabel?.text = "text"
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionObj = fetchedResultsController.object(at: indexPath)
       
        self.performSegue(withIdentifier: "toBuildingDetails", sender: self)
        
        
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
                self.buildingListTableView.deleteRows(at: [indexPath], with: .fade)
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





