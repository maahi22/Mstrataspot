//
//  SettingsVC.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    var settingsArray = [["icon":"showProfile","segu":"toAboutstrataspot","text":"About strataspot"],["icon":"showProfile","segu":"toEditCompanyInformation","text":"Edit Company Information"],["icon":"showProfile","segu":"toPostFeedback","text":"Post Feedback"], ["icon":"showProfile","segu":"toImageSavingOption","text":"Image Saving Option"],["icon":"showProfile","segu":"toRoutine Inspection Settings","text":"Routine Inspection Settings"],
        ["icon":"showProfile","segu":"toBackupRestore","text":"Backup / Restore"],
        ["icon":"showProfile","segu":"toMailSettings","text":"Mail Settings"],
        ["icon":"showProfile","segu":"toPINSettings","text":"PIN Settings"]]
    @IBOutlet weak var settingsTblView: UITableView!
    
    
    
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
    }
    

}


extension SettingsVC : UITableViewDelegate, UITableViewDataSource{
    
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
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        
        let dic = settingsArray[indexPath.row]
        cell.textLabel?.text = dic["text"]
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = settingsArray[indexPath.row]
        self.performSegue(withIdentifier: dic["segu"]!, sender: self)
        
    }
    
    
    
    
    
}
