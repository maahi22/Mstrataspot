//
//  BuildingDetails.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class BuildingDetails: UIViewController {//Area list

    
    @IBOutlet weak var LevelListTableView: UITableView!
    
    var inspectionManageobj : NSManagedObject!
    var sectionManageobj : NSManagedObject!
    
    var areaObj = NSManagedObject()
    var objStatus :Bool = false
    
    
    
    private let persistentContainer = NSPersistentContainer(name: "Areas")
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Areas> = {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        
        let fetchRequest = NSFetchRequest<Areas>(entityName: "Areas")
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
        LevelListTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)  {
        LevelListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    @IBAction func EditLevel(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toEditSection", sender: self)
        
        
    }
    
    
    
    
    @IBAction func AddAreaName(_ sender: Any) {
         objStatus = false
        
        self.performSegue(withIdentifier: "toAddArea", sender: self)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toAddArea" {
            let nextScene =  segue.destination as! AddArea
            nextScene.sectionManageobj = self.sectionManageobj
            if objStatus {
                nextScene.areaManageobj  = self.areaObj
            }
        }
        else if segue.identifier == "toEditSection"{
        
            let nextScene =  segue.destination as! LevelVC
            nextScene.sectionManageobj = self.sectionManageobj
            
        }
        
        
        
    }
    

}

extension BuildingDetails: NSFetchedResultsControllerDelegate {
    
}


extension BuildingDetails : UITableViewDelegate, UITableViewDataSource{
    
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
        let area = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.textLabel?.text = area.name
        
        // print(Projects.title)
        
        
        
        
        
        // cell.textLabel?.text = "text"
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        areaObj = fetchedResultsController.object(at: indexPath)
        objStatus = true
        self.performSegue(withIdentifier: "toAddArea", sender: self)
        
        
    }
    
    
    
    /*func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
        
        
    }*/
    
}
