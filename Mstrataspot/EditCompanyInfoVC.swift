//
//  EditCompanyInfoVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class EditCompanyInfoVC: UIViewController,SignatureDelegate {

    
    
    
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtFax: UITextField!
    @IBOutlet weak var txtWebsiteName: UITextField!
    @IBOutlet weak var txtLicence: UITextField!
    @IBOutlet weak var txtQualification: UITextField!
    
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    
    @IBOutlet weak var imgSigneture:UIImageView!
    @IBOutlet weak var imgCompanyLogo: UIImageView!
    @IBOutlet weak var companyScrollView: UIScrollView!
    
    @IBOutlet weak var txtViewQualification: UITextView!
    @IBOutlet weak var btnSigneture: UIButton!
    @IBOutlet weak var btnCompanyImage: UIButton!
    
    var chosenImage : UIImage = UIImage()
    let imagePicker = UIImagePickerController()
    
    
    var list : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var list: NSManagedObject? = nil
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let lists = fetchRecordsForEntity("CompanyInfo", inManagedObjectContext: context)
        
        if let listRecord = lists.first {
            list = listRecord
        } /*else if let listRecord = createRecordForEntity("CompanyInfo", inManagedObjectContext: context) {
            list = listRecord
        }*/
        
        
        if list != nil {
            
            txtEmployeeName.text = list?.value(forKey: "employeeName") as? String
            txtCompanyName.text = list?.value(forKey: "companyName") as? String
            txtAddress.text = list?.value(forKey: "address1") as? String
            txtAddress2.text = list?.value(forKey: "address2") as? String
            txtEmail.text = list?.value(forKey: "email") as? String
            txtPhone.text = list?.value(forKey: "phone") as? String
            txtFax.text = list?.value(forKey: "fax") as? String
            txtWebsiteName.text = list?.value(forKey: "webSite") as? String
            txtLicence.text = list?.value(forKey: "license") as? String
            txtViewQualification.text = list?.value(forKey: "qualifications") as? String
            txtCity.text = list?.value(forKey: "city") as? String
            txtState.text = list?.value(forKey: "state") as? String
            txtZip.text = list?.value(forKey: "zip") as? String
            
            if  list?.value(forKey: "companyLogoImage") != nil{
                imgCompanyLogo.image = UIImage(data:list?.value(forKey: "companyLogoImage") as! Data,scale:1.0)
            }
            
            if  list?.value(forKey: "signatureImage") != nil{
                imgSigneture.image = UIImage(data:list?.value(forKey: "signatureImage") as! Data,scale:1.0)
            }
            
        }
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FilesMethods.getImageFromDocDir("signature") { (img, sts) in
            
            if sts {
                self.imgSigneture.image = img
            }
            
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
    

    private func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject?
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
    
    
    
    
    
    @IBAction func saveCompnyInfo(_ sender: Any) {
        
        guard
        let BMName = txtEmployeeName.text, !BMName.isEmpty,
        let compName = txtCompanyName.text, !compName.isEmpty,
        let add1 = txtAddress.text, !add1.isEmpty,
        let add2 = txtAddress2.text, !add2.isEmpty,
        let email = txtEmail.text, !email.isEmpty,
        let phone = txtPhone.text, !phone.isEmpty,
        let fax = txtFax.text, !fax.isEmpty,
        let website = txtWebsiteName.text, !website.isEmpty,
        let licence = txtLicence.text, !licence.isEmpty,
        let qualification = txtViewQualification.text, !qualification.isEmpty,
        let city = txtCity.text, !city.isEmpty,
        let state = txtState.text, !state.isEmpty,
        let zip = txtZip.text, !zip.isEmpty
        
        else {
            
            
                let alert = UIAlertController(title: "Alert", message: "Please fill all mendatory fields", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                txtEmployeeName.resignFirstResponder()
                txtCompanyName.resignFirstResponder()
                return
        }
        
        
        
        //Save inside
        

        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        if list != nil {
            
            list.setValue(BMName, forKey: "employeeName")
            list.setValue(compName, forKey: "companyName")
            list.setValue(add1, forKey: "address1")
            list.setValue(add2, forKey: "address2")
            list.setValue(email, forKey: "email")
            list.setValue(phone, forKey: "phone")
            list.setValue(fax, forKey: "fax")
            list.setValue(website, forKey: "webSite")
            list.setValue(licence, forKey: "license")
            list.setValue(qualification, forKey: "qualifications")
            list.setValue(city, forKey: "city")
            list.setValue(state, forKey: "state")
            list.setValue(zip, forKey: "zip")
            
            if let img = self.imgCompanyLogo.image {
                let imgData = UIImageJPEGRepresentation(img, 1)
                list.setValue(imgData, forKey: "companyLogoImage")
            }
            
            if let img = self.imgSigneture.image {
                let imgData = UIImageJPEGRepresentation(img, 1)
                list.setValue(imgData, forKey: "signatureImage")
            }
            
            
            do {
                try list.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Company info update succesfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            } catch {
                print("Error occured during save entity")
            }

            
        }
        else{
            
            
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntityCompanyInfo, in: context)
            
            
            let building = NSManagedObject(entity: entityDescription!, insertInto: context)
            building.setValue(BMName, forKey: "employeeName")
            building.setValue(compName, forKey: "companyName")
            building.setValue(add1, forKey: "address1")
            building.setValue(add2, forKey: "address2")
            building.setValue(email, forKey: "email")
            building.setValue(phone, forKey: "phone")
            building.setValue(fax, forKey: "fax")
            building.setValue(website, forKey: "webSite")
            building.setValue(licence, forKey: "license")
            building.setValue(qualification, forKey: "qualifications")
            building.setValue(city, forKey: "city")
            building.setValue(state, forKey: "state")
            building.setValue(zip, forKey: "zip")
            
            if let img = self.imgCompanyLogo.image {
                let imgData = UIImageJPEGRepresentation(img, 1)
                building.setValue(imgData, forKey: "companyLogoImage")
            }
            
            if let img = self.imgSigneture.image {
                let imgData = UIImageJPEGRepresentation(img, 1)
                building.setValue(imgData, forKey: "signatureImage")
            }
            
            
            do {
                try building.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Company info save succesfully. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            } catch {
                print("Error occured during save entity")
            }
        }
    }
    
    
    
    @IBAction func EditCompanyPic(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.shootPhoto()
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { action in
            self.photoFromLibrary()
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))

        
    }
    
    
    
    @IBAction func AddSignature(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showSignatureView", sender: self)
        
        
    }
    
    
    
    //Signature delegate methods
    func returnSignatureImage(_ image : UIImage){
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignatureView" {
            let nextScene =  segue.destination as! SignatureVC
            // Pass the selected object to the new view controller.
            nextScene.delegate = self
            
        }
        
        
    }
    

}


//Camera picker Extension
extension EditCompanyInfoVC :UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    func photoFromLibrary() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker,  animated: true, completion: nil)//4
        //imagePicker.popoverPresentationController?.barButtonItem = sender
        
    }
    
    func shootPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,  animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //let chosenImage : UIImage
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imgCompanyLogo.image = chosenImage
            
        } else if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imgCompanyLogo.image = chosenImage
        }
        
       // self.imgCompanyImage.layer.cornerRadius =  self.imgCompanyImage.frame.size.width / 2
        dismiss(animated: true, completion: nil) //5
    }
    
    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true,    completion: nil)
    }
    
    
}


extension EditCompanyInfoVC :UITextFieldDelegate,UITextViewDelegate {

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       /* if textField.returnKeyType == .next {
            txtPassword.becomeFirstResponder()
        }else  if textField.returnKeyType == .go {
            self.userLogin(self)
            
        }*/
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return false
    }
    
    
    
    

}
