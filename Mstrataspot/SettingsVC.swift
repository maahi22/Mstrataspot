//
//  SettingsVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import MessageUI



class SettingsVC: UIViewController {

    var settingsArray = [["icon":"showProfile","segu":"toAboutstrataspot","text":"About strataspot"],["icon":"EditCompanyInformation","segu":"toEditCompanyInformation","text":"Edit Company Information"],["icon":"showProfile","segu":"toPostFeedback","text":"Post Feedback"], ["icon":"showProfile","segu":"toMailSettings","text":"Image Saving Option"],["icon":"showProfile","segu":"toRouteenInspectonSettings","text":"Routine Inspection Settings"],
        ["icon":"showProfile","segu":"toBackupRestore","text":"Backup / Restore"],
        ["icon":"showProfile","segu":"toMailSettings","text":"Mail Settings"],
        ["icon":"showProfile","segu":"toMailSettings","text":"PIN Settings"]]
    @IBOutlet weak var settingsTblView: UITableView!
    
    var Status = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
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
        
        
        if segue.identifier == "toMailSettings" {
            let nextScene =  segue.destination as! MailSettingVC
            // Pass the selected object to the new view controller.
            nextScene.status = self.Status
        
        }
        
        
        
        
        
    }
    

}


extension SettingsVC : UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate{
    
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
        
        return settingsArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row ,indexPath.section)
        if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.hexStringToUIColor(hex: stratspot_Rollover_colour_nav_colour)
        }else{
            cell.backgroundColor = UIColor.white
        }
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        
        let dic = settingsArray[indexPath.row]
        cell.textLabel?.text = dic["text"]
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let dic = settingsArray[indexPath.row]
        
        if indexPath.row == 2{//Feedback
            
            self.sendFeedback()
            
        }else if indexPath.row == 7 {//pin
            self.Status = 1
            self.performSegue(withIdentifier: dic["segu"]!, sender: self)
       
        
        }else if indexPath.row == 3 {//save image
            self.Status = 3
            self.performSegue(withIdentifier: dic["segu"]!, sender: self)
            
            
        }else{
        
        
        self.Status = 0
        self.performSegue(withIdentifier: dic["segu"]!, sender: self)
        }
    }
    
    
    func sendFeedback(){
        
        if MFMailComposeViewController.canSendMail() {
            
         //   UINavigationBar.appearance().barTintColor = UIColor.hexStringToUIColor(hex: MyDunia_colorPrimary)
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            // Configure the fields of the interface.
            composeVC.setToRecipients([supportmailId])
            composeVC.setSubject("FeedBack")
            composeVC.setMessageBody("", isHTML: false)
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Alert", message: "Please configure mail", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            print("Mail services are not available")
            return
            
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // print(error)
        controller.dismiss(animated: true, completion: nil)
    }
    
}
