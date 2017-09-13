//
//  PDFBuilderManage.swift
//  Mstrataspot
//
//  Created by Maahi on 13/09/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit


let ApprovADDY  = 20
let pdfPageHEIGHT = 842
let pdfPageWidth = 712
let pdfThird_Width = 712/3

let kBorderInset = 20
let kMarginInset = 0
let kLineWidth = 100
let kBorderWidth = 1
let imgStatus = 0

let pageSize = CGSize(width: pdfPageWidth, height: pdfPageHEIGHT)


class PDFBuilderManage: NSObject {
    
    
    class func drawLine(){
        
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(2.0)
        context!.setStrokeColor(UIColor.black.cgColor)
        
        var xAxis:Int = kMarginInset
        xAxis = xAxis + kBorderInset
        
        var yAxis:Int = kMarginInset
        yAxis = yAxis + kBorderInset+40
        
        
        let startPoint = CGPoint(x: xAxis, y: yAxis)
        let endPoint = CGPoint(x: CGFloat(pageSize.width) - 2 * CGFloat(kMarginInset) - 2 * CGFloat(kBorderInset), y: CGFloat(kMarginInset) + CGFloat(kBorderInset) + 40.0)
            
    
        
        context?.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context?.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        context!.strokePath()
        
        
    }
    
    class func drawLineFromPointFrom (_ from : CGPoint, toPoint:CGPoint,  height:Double ,value:Int) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(2.0)
        context!.setStrokeColor(UIColor.black.cgColor)
        
        
        
    }
    
    class func drawBorder(){
        
        
        
        
    }
    
    

    
    
    
    
    
    
    
     class func generatePdf (_ project:Projects ,companyInfo:CompanyInfo)->String{
        
        
        var currentY:CGFloat = 0.0
        
        
        let dateformater = DateFormatter()
        dateformater.dateFormat = "dd-MM-YYYY hh:mm"
        dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone!
        var now = DefaultDataManager.AppCurrentTime()
        
        var   fileName = ""
        if let title = project.title {
            fileName = "\(title) \(String(describing: project.reference)) \(dateformater.string(from: now as Date)).pdf"
        }
        
        
        let pdfFileName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
        
        
        
        UIGraphicsBeginPDFContextToFile(pdfFileName, CGRect.zero, nil)
        var currentPage = 0
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
        
        currentPage += 1
        
        currentY = 45
        
        var currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
       
        if project.projectImage != nil && project.projectImage != "" {
            
            let demoImage = FilesMethods.loadImage(project.projectImage!)
            var imageHeight = demoImage.size.height
            var imageWidth = demoImage.size.width
            
            if imageHeight > 156
            {
                imageWidth = (imageWidth / imageHeight) * 156.0
                imageHeight = 156.0
                
                
                if imageWidth > 612 {
                    imageWidth = 612
                    
                }
                
            }
            
            let rect = CGRect (x: 200.0, y: currentY, width: imageWidth, height: imageHeight)
            demoImage.draw(in:rect )
            currentY = currentY + 156 + 10
            
        }else{
            currentY = currentY + 156 + 10
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        UIGraphicsEndPDFContext()
        return pdfFileName;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    class func generate_DocFromProject (_ project:Projects ,companyInfo:CompanyInfo)->String{
        
        let dateformater = DateFormatter()
        dateformater.dateFormat = "dd-MM-YYYY hh:mm"
        dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone!
        var now = DefaultDataManager.AppCurrentTime()
        
        var   fileName = ""
        if let title = project.title {
            fileName = "\(title) \(String(describing: project.reference)) \(dateformater.string(from: now as Date)).doc"
        }
        
        
        let docFileName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
        
      var  docTextLength = 0
        
        let strTitle = "\(String(describing: project.title?.uppercased()))\n\n"
        
        let strContactNameBS = "Contact Name:"
        var strContactName = ""
        if let name = project.clientName {
            strContactName = "\(name)\n\n"
        }
        
        
        let strOrganizationBS = "Organization Name:"
        let strOrganization = " \(String(describing: project.organizationName))\n\n"
        
        let strAddress1BS = "Address:"
        let strAddress1 = " \(String(describing: project.clientAddress1))"
        let strAddress2 = ",\(String(describing: project.clientAddress2))"
        let strAddress3 = ", Australia\n\n\n\n\n"
        
        let strPreparedBS = "Prepared By:"
        var strPrepared = ""
        if let emplname = project.employeeName {
            strPrepared = "\(emplname)\n\n"
        }
        
        let strCompanyNameBS = "Company Name:"
        var strCompanyName = ""
        if let compName = project.companyName {
            strCompanyName = " \(compName)\n\n"
        }

        
        let strCmpAddressBS = "Address:"
        let strCmpAddress1 = " \(String(describing: project.address1))"
        let strCmpAddress2 = ",\(String(describing: project.address2))"
        let strCmpAddress3 = ", Australia\n\n"
        
        
        let strPhonBS = "Phone:"
        var strPhon = ""
        if let Phone = companyInfo.phone {
            strPhon = " \(Phone)\n\n"
        }
        
        
        
        let strFaxBS = "Fax:"
        var strFax = ""
        if let fax = companyInfo.fax {
            strFax = "\(fax)\n\n"
        }
        
        let strEmailBS = "Email:"
        var strEmail = ""
        if let email = companyInfo.email {
            strEmail = " \(email)\n\n\n\n\n\n\n"
        }
        
        
        
        
        let strDescription = "Project Description\n"
        let strDescriptionValue = "\(String(describing: project.project_description))\n\n\n"
        
        
        dateformater.dateFormat = "MMMM dd, YYYY"
        dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone
        now = DefaultDataManager.AppCurrentTime()
        
        let strSignature = "Signature Approved by\n"
        let strSignatureDate = "Date Approved: \(dateformater.string(from: now as Date))\n\n\n\n"
        
        
        
        let strInspect = "The Inspection\n\n"
        let strInspectStr = "The basis of this report is an inspection of the common property areas of the scheme. This report is not an all encompassing report dealing with the scheme common areas from every aspect. It is a reasonable attempt to identify any obvious and significant defects upon common property areas of the scheme. This report is not a certificate of compliance with respect to any Act, Regulation, Ordinance or By-law. The report is not a structural report and should you require any advice of a structural nature we recommend our structural engineer be engaged.\n\nThe inspection of the common property of the scheme is a visual inspection only limited to those areas of the common property that are fully accessible and visible to the inspector at the time of inspection. The inspection did not include breaking apart, dismantling, removing or moving any element of the building and items located on the common property.\n\nThe report does not and cannot make comment upon: defects that may have been concealed; the assessment of which may rely on certain weather conditions; the presence or absence of timber pests; gas fittings; heritage concerns; site drainage; security concerns; detection and identification of illegal building work; durability of exposed finishes; the roof space and under floor space.\n\nThe inspector will identify and assess hazards relating to the static condition of the common property and then recommend remedial action or the introduction of a suitable control measure. This report is not an Asbestos Audit and no assessment of potential asbestos materials is made.\n\n"
        
        let strPurpose = "Purpose of Report\n\n"
        let  strPurposeSTR = "The purpose of this report is to increase awareness of risk and potential exposures to the property from OHS&E defects. The report is primarily intended solely for use by Building Manager and the Management Committee. Recommendations are listed where specific improvements are required to meet relevant standards.\n\n"
        
        let strDisclaimer = "Disclaimer\n\n"
        let  strDisclaimerStr = "This report has been prepared by \(companyInfo.companyName) and is based on site inspections and information provided by site contact. In the circumstances, \(companyInfo.companyName) nor any of its directors or employees give any warranty in relation to the accuracy or reliability of any information contained in this report. \(companyInfo.companyName) disclaims all liability to any party (including any indirect or consequential loss or damage or loss of profits) in respect of or in consequence of anything done or omitted to be done by any party in reliance, whether in whole or partial, upon any information contained in this report. Any party who chooses to rely in any way upon the contents of this report does so at its own risk.\n\n"
        
        // NSLog(@"strDisclaimerStr  %@",strDisclaimerStr);
        
        let strPriority = "Priority Key\n"
        let strPrioritySTR = "Urgency for rectifying the items listed below have been classified in this table from very low to extreme.\n"
        
        
        
        

        
        
        
        
        
        
        
        
      return docFileName
    }
}
