//
//  NewProjectVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData



class NewProjectVC: UIViewController,ContactListDelegate,SignatureDelegate {

    
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var txtProjectReference: UITextField!
    
    @IBOutlet weak var txtReference: UITextField!
    @IBOutlet weak var txtOrganizationName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    
    @IBOutlet weak var txtClientName: UITextField!
    @IBOutlet weak var txtClientAddress1: UITextField!
    @IBOutlet weak var txtClientAddress2: UITextField!
    @IBOutlet weak var txtClientCity: UITextField!
    @IBOutlet weak var txtClientState: UITextField!
    @IBOutlet weak var txtClientZip: UITextField!
    
    
    
    
  
    
    
    @IBOutlet weak var clientSignImgView: UIImageView!
    @IBOutlet weak var comSignImgView: UIImageView!
    
    
    
    var editProjectManageobj : NSManagedObject!
    var clientNameSts  = 0
    var signtureCompnySts  = 0
    
    
    @IBOutlet weak var projectImageView: UIImageView!
    
    var chosenImage : UIImage = UIImage()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if editProjectManageobj != nil {
            
            if let title = editProjectManageobj.value(forKey: "title"){
                txtTitle.text = title as! String
            }
            if let desc = editProjectManageobj.value(forKey: "project_description"){
                txtViewDescription.text = desc as! String
            }
            
            
           
            
            
        }
        
        
        
    }

    
    
    @IBAction func selectClientName(_ sender: Any) {
        self.clientNameSts = 1
        self.performSegue(withIdentifier: "toContactList", sender: self)
        
    }
    
    @IBAction func getAddressBook(_ sender: Any) {
        self.clientNameSts = 0
        self.performSegue(withIdentifier: "toContactList", sender: self)
        
        
    }
    
    @IBAction func saveProjects(_ sender: Any) {
        
        
        
        guard
            let title = txtTitle.text, !title.isEmpty,
            let desc = txtViewDescription.text, !desc.isEmpty
            else {
                
                if txtTitle.text == "" {
                    let alert = UIAlertController(title: "Error!", message: "Please enter a title.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else if txtViewDescription.text == "" {
                    let alert = UIAlertController(title: "Error!", message: "Please add a description here.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
                txtTitle.resignFirstResponder()
                txtViewDescription.resignFirstResponder()
                return
        }

        
        
        
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        if editProjectManageobj != nil {
            
            
            
        }else{
            
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntityProjects, in: context)
            let now = DefaultDataManager.AppCurrentTime()
            let Projects = NSManagedObject(entity: entityDescription!, insertInto: context)
            Projects.setValue(title, forKey: "title")
            Projects.setValue(desc, forKey: "project_description")
            Projects.setValue(txtAddress.text, forKey: "address1")
            Projects.setValue(txtAddress2.text, forKey: "address2")
            Projects.setValue(txtCity.text, forKey: "city")
            Projects.setValue(txtCompanyName.text, forKey: "companyName")
            Projects.setValue(now, forKey: "creationDate")
            Projects.setValue(txtEmployeeName.text, forKey: "employeeName")
            Projects.setValue(txtClientAddress1.text, forKey: "clientAddress1")
            Projects.setValue(txtClientAddress2.text, forKey: "clientAddress2")
            Projects.setValue(txtClientCity.text, forKey: "clientCity")
            Projects.setValue(txtClientName.text, forKey: "clientName")
           // Projects.setValue(title, forKey: "clientsSignatureFileName")
            Projects.setValue(txtClientState.text, forKey: "clientState")
            Projects.setValue(txtClientZip.text, forKey: "clientZip")
            Projects.setValue(txtOrganizationName.text, forKey: "organizationName")
           // Projects.setValue(title, forKey: "projectImage")
            Projects.setValue(txtProjectReference.text, forKey: "projectReference")
            Projects.setValue(txtReference.text, forKey: "reference")
            Projects.setValue(txtState.text, forKey: "state")
            Projects.setValue(txtZip.text, forKey: "zip")
            do {
                try Projects.managedObjectContext?.save()
                let alert = UIAlertController(title: "Alert", message: "Project  save succesfully. ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            } catch {
                print("Error occured during save entity")
            }

            
        }
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func selectProjectImage(_ sender: Any) {
        
        let uiAlert = UIAlertController(title: "Project Image", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
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
    
    
    @IBAction func clientSignature(_ sender: Any) {
        signtureCompnySts = 0
         self.performSegue(withIdentifier: "showSignatureView", sender: self)
    }
    
    @IBAction func openSignature(_ sender: Any) {
        signtureCompnySts = 1
        self.performSegue(withIdentifier: "showSignatureView", sender: self)
    }
    
    
    //Signature delegate
    func returnSignatureImage(_ image : UIImage){
        if signtureCompnySts == 1 {
            comSignImgView.image = image
        }else{
            clientSignImgView.image = image
        }
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactList" {
            let nextScene =  segue.destination as! ContactListVC
            nextScene.delegate = self
           
        }else if segue.identifier == "showSignatureView" {
            let nextScene =  segue.destination as! SignatureVC
            nextScene.delegate = self
            
        }

    }
    //Contact Delegate method
    func ConatctName(_ contactname : String){
        if self.clientNameSts == 1{
            txtClientName.text = contactname
        }else {
            txtEmployeeName.text   = contactname
        }
    }
    
    
    
}

extension NewProjectVC:UITextViewDelegate {
    
    
}

extension NewProjectVC: UITextFieldDelegate {
    
    
}

//Camera picker Extension
extension NewProjectVC :UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
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
            self.projectImageView.image = chosenImage
            
        } else if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.projectImageView.image = chosenImage
        }
        
        // self.imgCompanyImage.layer.cornerRadius =  self.imgCompanyImage.frame.size.width / 2
        dismiss(animated: true, completion: nil) //5
    }
    
    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true,    completion: nil)
    }
    
    
}
