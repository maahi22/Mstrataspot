//
//  IssueVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData

class IssueVC: UIViewController,PeriorityDelegate {

    
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var txtViewComments: UITextView!
    @IBOutlet weak var btnPriority: UIButton!
    @IBOutlet weak var imgViewPhoto: UIImageView!
    @IBOutlet weak var btnTapImage: UIButton!
    @IBOutlet weak var issueScrollView: UIScrollView!
    
    
    var projectManageobj : NSManagedObject!
    
    let imagePicker = UIImagePickerController()
    var hasImage = false
    var CurvesData = ""
    var priorityColor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    func PeriorityClick(_ periority : String){
        
        
    }
    
    
    @IBAction func saveIssue(_ sender: Any) {
        
        var imageName = ""
        if imgViewPhoto.image != nil{
            hasImage = true
            imageName = FilesMethods.saveImage(imgViewPhoto.image!)
            
        }
        
        
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
                txtTitle.resignFirstResponder()
                return
        }
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        let entityDescription = NSEntityDescription.entity(forEntityName: kEntityIssues, in: context)
        
        
        let now = DefaultDataManager.AppCurrentTime()
        
        
        let Issues = NSManagedObject(entity: entityDescription!, insertInto: context)
        Issues.setValue(title, forKey: "title")
        Issues.setValue(desc, forKey: "issue_description")
        Issues.setValue(hasImage, forKey: "hasImage")
        Issues.setValue(now, forKey: "creationDate")
        Issues.setValue(priorityColor, forKey: "priority")
        Issues.setValue(imageName, forKey: "imageName")
        Issues.setValue(CurvesData, forKey: "imageCurves")
        Issues.setValue(txtViewComments.text, forKey: "comment")
        //saverelationship
        Issues.setValue(projectManageobj, forKey: "project")
        
        
        do {
            try Issues.managedObjectContext?.save()
            
            let alert = UIAlertController(title: "Alert", message: "Issue  save succesfully. ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        } catch {
            print("Error occured during save entity")
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


extension IssueVC: UITextViewDelegate{
    
}

extension IssueVC: UITextFieldDelegate{
    
    
}



//Camera picker Extension
extension IssueVC :UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
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
           let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imgViewPhoto.image = chosenImage
            
        } else if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
          let  chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imgViewPhoto.image = chosenImage
        }
        
      //  self.imgViewPhoto.layer.cornerRadius =  self.imgViewPhoto.frame.size.width / 2
        dismiss(animated: true, completion: nil) //5
    }
    
    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true,    completion: nil)
    }
    
    
}

