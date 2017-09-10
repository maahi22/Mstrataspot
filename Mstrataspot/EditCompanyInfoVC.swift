//
//  EditCompanyInfoVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/5/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData


class EditCompanyInfoVC: UIViewController {

    
    
    
    @IBOutlet weak var txtBMName: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtFax: UITextField!
    @IBOutlet weak var txtEmployeeName: UITextField!
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    
    
    
    
    @IBAction func saveCompnyInfo(_ sender: Any) {
        
        guard
        let BMName = txtBMName.text, !BMName.isEmpty,
        let compName = txtCompanyName.text, !compName.isEmpty,
        let add1 = txtAddress.text, !add1.isEmpty,
        let add2 = txtAddress2.text, !add2.isEmpty,
        let email = txtEmail.text, !email.isEmpty,
        let phone = txtPhone.text, !phone.isEmpty,
        let fax = txtFax.text, !fax.isEmpty,
        let empName = txtEmployeeName.text, !empName.isEmpty,
        let licence = txtLicence.text, !licence.isEmpty,
        let qualification = txtViewQualification.text, !qualification.isEmpty,
        let city = txtCity.text, !city.isEmpty,
        let state = txtState.text, !state.isEmpty,
        let zip = txtZip.text, !zip.isEmpty
        
        else {
            
            
                let alert = UIAlertController(title: "Alert", message: "Please enter the login credential", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                txtBMName.resignFirstResponder()
                txtCompanyName.resignFirstResponder()
                return
        }
        
        
        
        //Save inside
        

        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntityCompanyInfo, in: context)
        
        
        let building = NSManagedObject(entity: entityDescription!, insertInto: context)
       // building.setValue(BMName, forKey: "title")
        building.setValue(compName, forKey: "companyName")
        building.setValue(add1, forKey: "address1")
        building.setValue(add2, forKey: "address2")
        building.setValue(email, forKey: "email")
        building.setValue(phone, forKey: "phone")
        building.setValue(fax, forKey: "fax")
        building.setValue(empName, forKey: "employeeName")
        building.setValue(licence, forKey: "license")
        building.setValue(qualification, forKey: "qualifications")
        building.setValue(city, forKey: "city")
        building.setValue(state, forKey: "state")
        building.setValue(zip, forKey: "zip")
        
        
        do {
            try building.managedObjectContext?.save()
        } catch {
            print("Error occured during save entity")
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
