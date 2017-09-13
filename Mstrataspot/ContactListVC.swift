//
//  ContactListVC.swift
//  Mstrataspot
//
//  Created by Rajeev kumar singh on 9/13/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import Contacts

protocol ContactListDelegate {
    
    
    func ConatctName(_ contactname : String)
}


class ContactListVC: UIViewController {

    let store = CNContactStore()
    
    var contactNameArray = NSMutableArray()
    
    var delegate:ContactListDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
            
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            
            do {
                try self.store.enumerateContacts(with: request) { contact, stop in
                    if let name = formatter.string(from: contact) {
                        print(name)
                        self.contactNameArray.add(name)
                    }
                }
            } catch let fetchError {
                print(fetchError)
            }
        }

        
        
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

extension ContactListVC : UITableViewDelegate, UITableViewDataSource{
    
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
        
        
        return self.contactNameArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        
        // Configure Cell
        cell.textLabel?.text = self.contactNameArray[indexPath.row] as! String
        
       
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        delegate?.ConatctName(self.contactNameArray[indexPath.row] as! String)
        
        
    }
    
    
    
}


