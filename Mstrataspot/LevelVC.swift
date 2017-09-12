//
//  LevelVC.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import CoreData
import QRCodeReader
import AVFoundation



class LevelVC: UIViewController,QRCodeReaderViewControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblGPSLocation: UILabel!
    @IBOutlet weak var lblQACode: UILabel!
    
    
   var inspectionManageobj : NSManagedObject!
   var sectionManageobj : NSManagedObject!
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    
   var locationManager = LocationManager.sharedInstance
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get GPS location
        locationManager.autoUpdate = true
        locationManager.startUpdatingLocationWithCompletionHandler { (lat, lang, Status, verboseMsg, error)  in
            
            DispatchQueue.main.async(execute: { [weak self] () -> Void  in
                guard let strongSelf = self else { return }
                strongSelf.lblGPSLocation.text = "\(lat),\(lang)"
            })

            
            
            
            if Status != "Allowed access" {
                
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Please put ON your location service for accurate results", comment: ""), preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
                let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (UIAlertAction) in
                    
                    if #available(iOS 10.0, *) {
                         UIApplication.shared.open(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                        
                    } else {
                        UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                    }
                }
                alertController.addAction(settingsAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
//ENDED
        
        
        if sectionManageobj != nil {
            
            if let name = sectionManageobj.value(forKey: "name"){
                
                self.txtName.text = name as? String
            }
            
            if let gps = sectionManageobj.value(forKey: "gpsLocation"){
                
                self.lblGPSLocation.text = gps as? String
            }
            
            if let qrCode = sectionManageobj.value(forKey: "qrCode"){
                
                self.lblQACode.text = qrCode as? String
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    @IBAction func scaneCode(_ sender: Any) {
        
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result?.value)
            
            self.lblQACode.text = result?.value
           // self.readerVC.dismiss(animated: true, completion: nil)
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
        
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    //QR CODE ENDED
    
    
    
    
    
    @IBAction func scanLocation(_ sender: Any) {
        
        
        
    }
    
    
    
    
    @IBAction func saveSection(_ sender: Any) {
        
        
      
        
        
        
        guard
            let name = txtName.text, !name.isEmpty
            else {
                
                
                let alert = UIAlertController(title: "Alert", message: "Please enter a section name.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        guard
            let gpsloc = lblGPSLocation.text, !gpsloc.isEmpty
            else {
                let alert = UIAlertController(title: "Error", message: "Please enter a GPS location.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        
        guard
            let qrCode = lblQACode.text, !qrCode.isEmpty
            else {
                let alert = UIAlertController(title: "Error", message: "Please scan a valid QR code.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                return
        }
        
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.getContext()
        
        if sectionManageobj != nil {
            
           
            // building.setValue(BMName, forKey: "title")
            sectionManageobj.setValue(name, forKey: "name")
            sectionManageobj.setValue(qrCode, forKey: "qrCode")
            sectionManageobj.setValue(gpsloc, forKey: "gpsLocation")
            //sectionManageobj.setValue(inspectionManageobj, forKey: "routineInspection")//set Reelationship
            
            do {
                try sectionManageobj.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Information update succesfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("Error occured during save entity")
            }
            
            
            
        }else{
            let entityDescription = NSEntityDescription.entity(forEntityName: kEntitySections, in: context)
            let sections = NSManagedObject(entity: entityDescription!, insertInto: context)
            // building.setValue(BMName, forKey: "title")
            sections.setValue(name, forKey: "name")
            sections.setValue(qrCode, forKey: "qrCode")
            sections.setValue(gpsloc, forKey: "gpsLocation")
            sections.setValue(inspectionManageobj, forKey: "routineInspection")//set Reelationship
            
            do {
                try sections.managedObjectContext?.save()
                
                let alert = UIAlertController(title: "Alert", message: "Information save succesfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("Error occured during save entity")
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
