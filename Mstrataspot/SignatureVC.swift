//
//  SignatureVC.swift
//  Mstrataspot
//
//  Created by Maahi on 12/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit
import SwiftSignatureView


protocol SignatureDelegate {
    func returnSignatureImage(_ image : UIImage)
}




class SignatureVC: UIViewController {
   
    
    
    
   
    var delegate:SignatureDelegate?

    @IBOutlet weak var signatureView: SwiftSignatureView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FilesMethods.getImageFromDocDir("signature") { (img, sts) in
            
            if sts {
               // self.signatureView.si = img
            
            
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func EraseSignature(_ sender: Any) {
        
        
        signatureView.clear()
        
    }
    
    
    
    @IBAction func unduSignature(_ sender: Any) {
        signatureView.clear()
        
        FilesMethods.getImageFromDocDir("signature") { (img, sts) in
            
            if sts {
                //self.signatureView.signature = img
            }
            
        }

        
    }

    
    
    
    @IBAction func saveSignature(_ sender: Any) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        signatureView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
      //  UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
      //  signatureView.signature
        
        
        
        
        FilesMethods.saveImageDocumentDirectory("signature", imageData: (UIImagePNGRepresentation(image!) as NSData?)!)
        
        
        
        delegate?.returnSignatureImage(image!)
        
        self.navigationController?.popViewController(animated: true)
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
