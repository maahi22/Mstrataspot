//
//  ReportsDetailsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData
import MessageUI


class ReportsDetailsVC: UIViewController,MFMailComposeViewControllerDelegate {

    
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

        if let title = detailProjectManageobj.value(forKey: "title"){
             self.title = title as? String 
        }
    
    
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
           
            var companyInfo : CompanyInfo!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            let lists = self.fetchRecordsForEntity("CompanyInfo", inManagedObjectContext: context)
            if let listRecord = lists.first {
                companyInfo = listRecord as! CompanyInfo
            }

            var PDF_fileName =  ""
            if let project = self.detailProjectManageobj , let comp = companyInfo {
                PDF_fileName = PDFBuilderManage.generatePdf(project as! Projects, companyInfo: comp )
            }
            
            
            
            if MFMailComposeViewController.canSendMail() {
                
                
                
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                // Configure the fields of the interface.
                composeVC.setToRecipients([supportmailId])
                composeVC.setSubject("")
                composeVC.setMessageBody("", isHTML: false)
                // Present the view controller modally.
                
                let dateformater = DateFormatter()
                dateformater.dateFormat = "dd-MM-YYYY hh:mm"
                dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone!
                let now = DefaultDataManager.AppCurrentTime()
                var   attachFileName = ""
                if let title = (self.detailProjectManageobj as! Projects).title , let ref = (self.detailProjectManageobj as! Projects).reference {
                    attachFileName = "\(title) \(ref) \(dateformater.string(from: now as Date)).pdf"
                }
                
                
                
                if let data = NSData(contentsOfFile: PDF_fileName) {
                    //Does not print. Nil?
                    composeVC.addAttachmentData(data as Data, mimeType: "application/pdf", fileName: "\(attachFileName)")
                }
                
                //************* Attached projectImage
                
                
                
                
                
                
                
                self.present(composeVC, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Alert", message: "Please configure mail", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("Mail services are not available")
                return
                
            }
            
            
            
            
            
        }))
        
        
        
        let btndoc:UIAlertAction  = (UIAlertAction(title: "Doc", style: .destructive, handler: { action in
           
            var companyInfo : NSManagedObject!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.getContext()
            let lists = self.fetchRecordsForEntity("CompanyInfo", inManagedObjectContext: context)
            if let listRecord = lists.first {
                companyInfo = listRecord
            }
            
             var docfileName =  ""
            if let project = self.detailProjectManageobj , let comp = companyInfo {
                 docfileName =   PDFBuilderManage.generate_DocFromProject(project as! Projects,  companyInfo: comp as! CompanyInfo )
            }
        print(docfileName)
            
            if MFMailComposeViewController.canSendMail() {
                
                
                
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                // Configure the fields of the interface.
                composeVC.setToRecipients([supportmailId])
                composeVC.setSubject("")
                composeVC.setMessageBody("", isHTML: false)
                // Present the view controller modally.
               
                let dateformater = DateFormatter()
                dateformater.dateFormat = "dd-MM-YYYY hh:mm"
                dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone!
                let now = DefaultDataManager.AppCurrentTime()
                var   attachFileName = ""
                if let title = (self.detailProjectManageobj as! Projects).title , let ref = (self.detailProjectManageobj as! Projects).reference {
                    attachFileName = "\(title) \(ref) \(dateformater.string(from: now as Date)).doc"
                }
                
            
                
                if let data = NSData(contentsOfFile: docfileName) {
                    //Does not print. Nil?
                    composeVC.addAttachmentData(data as Data, mimeType: "application/msword", fileName: "\(attachFileName)")
                    
                    
                    if self.detailProjectManageobj.value(forKey: "projectLogoImage") != nil {
                        let image = UIImage(data:self.detailProjectManageobj.value(forKey: "projectLogoImage") as! Data,scale:1.0)
                        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
                       
                        var Pname = "Project"
                        if let name = self.detailProjectManageobj.value(forKey: "title") {
                            Pname = name as! String
                        }
                        composeVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "\(Pname).png")
                        
                    }
                    
                    //signature
                    if self.detailProjectManageobj.value(forKey: "clientsSignatureFileName") != nil {
                        let image = UIImage(data:self.detailProjectManageobj.value(forKey: "clientsSignatureFileName") as! Data,scale:1.0)
                        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
                        composeVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "Signature.png")
                        
                    }
                    
                    
                    
                    
                    
                  if  let comp = companyInfo {
                        
                        
                        //company image
                        if comp.value(forKey: "companyLogoImage") != nil {
                            let image = UIImage(data:comp.value(forKey: "companyLogoImage") as! Data,scale:1.0)
                            let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
                            
                            var Cname = "Company"
                            if let name = comp.value(forKey: "companyName") {
                                Cname = name as! String
                            }
                            composeVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "\(Cname).png")
                            
                        }
                        
                        if comp.value(forKey: "signatureImage") != nil {
                            let image = UIImage(data:comp.value(forKey: "signatureImage") as! Data,scale:1.0)
                            let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
                            
                            var Pname = "Company_Signature"
                            
                            composeVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "\(Pname).png")
                            
                        }
                        
                    }
                    
                    //Issues data
                    let sectionSortDescriptor1 = NSSortDescriptor(key: "creationDate", ascending: true)
                    let sortDescriptors1 = [sectionSortDescriptor1]
                    let data = ((self.detailProjectManageobj.value(forKey: "issues") as AnyObject).allObjects! as NSArray).sortedArray(using: sortDescriptors1)

                    if data.count > 0 {
                        for i in 0...(data.count-1){
                            
                            let issue = data[i] as! Issues
                            
                            if issue.value(forKey: "issueImage") != nil {
                                let image = UIImage(data:issue.value(forKey: "issueImage") as! Data,scale:1.0)
                                let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
                                
                                var Pname = "issue"
                                if let name = issue.value(forKey: "title") {
                                    Pname = name as! String
                                }
                                composeVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "\(Pname).png")
                                
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                //************* Attached projectImage
                
                
                
                
                
                
                
                self.present(composeVC, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Alert", message: "Please configure mail", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("Mail services are not available")
                return
                
            }
            

            
            
            
            
        }))
        
        uiAlert.addAction(btnPdf)
        uiAlert.addAction(btndoc)
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))

        
        
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // print(error)
        controller.dismiss(animated: true, completion: nil)
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
