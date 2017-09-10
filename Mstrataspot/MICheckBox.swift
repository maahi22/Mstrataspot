//
//  MICheckBox.swift
//  Mstrataspot
//
//  Created by Maahi on 09/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit


protocol MICheckBoxDelegate {
    
    func MICheckBoxValueChange(_ checkBox : MICheckBox)
    
    
}

class MICheckBox: UIButton {

    var isChecked : Bool = false
    var isReadonly : Bool = false
    let isRadioButton : Bool = false
    
    var delegate:MICheckBoxDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    
    func checkBoxClicked(){
        if(isReadonly == false)
        {
            if(isRadioButton)
            {
                if(self.isChecked == false)
                {
                    self.isChecked = true
                    self.setImage(UIImage(named: "radio_checked")! as UIImage, for: .normal)
                    
                    delegate?.MICheckBoxValueChange(self)
                    
                    
                }
            }
            else
            {
                if(self.isChecked == false){
                    self.isChecked = true
                    self.setImage(UIImage(named: "checkbox_ticked")! as UIImage, for: .normal)
                    
                    
                    
                    
                }else{
                    self.isChecked = false
                    
                   self.setImage(UIImage(named: "checkbox_not_ticked")! as UIImage, for: .normal)
                }
                
                
                delegate?.MICheckBoxValueChange(self)
            }
        }
        
    }
    
    
    
    
    func Checked(_ check : Bool){
        
        if(check )
        {
            if(isRadioButton){
                self.setImage(UIImage(named: "radio_checked")! as UIImage, for: .normal)
                
            }else{
                
                self.setImage(UIImage(named: "checkbox_ticked")! as UIImage, for: .normal)
           
            }
        }
        else
        {
            if(isRadioButton){
                self.setImage(UIImage(named: "radio_unchecked")! as UIImage, for: .normal)
                
            }else{
                
                self.setImage(UIImage(named: "checkbox_not_ticked")! as UIImage, for: .normal)
                
            }
        }
        
        isChecked = check;

    }
    
    func SetRadioButton(){
        
        isReadonly = true
    }
    
    
    
}
