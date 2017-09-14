//
//  ReportsDetailsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData

class ReportsDetailsVC: UIViewController {

    
    var detailProjectManageobj : NSManagedObject!
    
    
    
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

        // Do any additional setup after loading the view.
    }

    
 
    
    private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    @IBAction func mailReportClicked(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "Mail report", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        let btnPdf:UIAlertAction  = (UIAlertAction(title: "Pdf", style: .destructive, handler: { action in
           
            var companyInfo : NSManagedObject!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            let lists = self.fetchRecordsForEntity("CompanyInfo", inManagedObjectContext: context)
            if let listRecord = lists.first {
                companyInfo = listRecord
            }

            let PDF_fileName = PDFBuilderManage.generatePdf(self.detailProjectManageobj as! Projects, companyInfo: companyInfo as! CompanyInfo)
            
            
        }))
        
        let btndoc:UIAlertAction  = (UIAlertAction(title: "Doc", style: .destructive, handler: { action in
           
            var companyInfo : NSManagedObject!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            let lists = self.fetchRecordsForEntity("CompanyInfo", inManagedObjectContext: context)
            if let listRecord = lists.first {
                companyInfo = listRecord
            }
            
         let docfileName =   PDFBuilderManage.generate_DocFromProject(self.detailProjectManageobj as! Projects, companyInfo: companyInfo as! CompanyInfo)
            
            
            
        }))
        
        uiAlert.addAction(btnPdf)
        uiAlert.addAction(btndoc)
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))

        
        
        
        
    }
    
    
    @IBAction func SortBy(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        let btnSeverityAscending:UIAlertAction  = (UIAlertAction(title: "Severity Ascending", style: .default, handler: { action in
            
            
            
            
            
        }))
        
        let btnSeverity:UIAlertAction  = (UIAlertAction(title: "Severity Descending", style: .default, handler: { action in
            
            
        
        }))
        
        let btnDateAscending:UIAlertAction  = (UIAlertAction(title: "Date Ascending", style: .default, handler: { action in
            
            
            
        }))
        
        let btnDateDescending:UIAlertAction  = (UIAlertAction(title: "Date Descending", style: .default, handler: { action in
            
            
            
        }))
        
        
        uiAlert.addAction(btnSeverityAscending)
        uiAlert.addAction(btnSeverity)
        uiAlert.addAction(btnDateAscending)
        uiAlert.addAction(btnDateDescending)
        
        
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

extension ReportsDetailsVC: NSFetchedResultsControllerDelegate {
    
}


extension ReportsDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let Projects = fetchedResultsController.fetchedObjects else { return 0 }
        return Projects.count
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as? ReportCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let Projects = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.lblTitle.text = Projects.title
        cell.lblDescription.text = Projects.project_description
        
        
        return cell
        
        
        
    }
    
    
    
    
}
