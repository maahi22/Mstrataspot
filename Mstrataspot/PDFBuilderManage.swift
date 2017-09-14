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
        if let title = project.title, let ref = project.reference {
            fileName = "\(title) \(ref) \(dateformater.string(from: now as Date)).pdf"
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
        
        
        if let title = project.title , let ref = project.reference {
            fileName = "\(title) \(ref) \(dateformater.string(from: now as Date)).doc"
        }
        
        
        let docFileName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
        
        var  docTextLength = 0
        
        
        var strTitle = ""
        if let title = project.title {
            strTitle = "\(title.uppercased())\n\n"
        }
        
        
        let strContactNameBS = "Contact Name:"
        var strContactName = ""
        if let name = project.clientName {
            strContactName = "\(name)\n\n"
        }
        
        
        let strOrganizationBS = "Organization Name:"
        var strOrganization = ""
        if let org = project.organizationName {
            strOrganization = " \(org)\n\n"
        }
        
        
        
        let strAddress1BS = "Address:"
        var strAddress1 = ""
        if let add1 = project.clientAddress1 {
            strAddress1 = " \(add1)"
        }
        var strAddress2 = ""
        if let add2 = project.clientAddress2 {
            strAddress2 = ",\(add2)"
        }
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
        var strCmpAddress = ""
        if let add1 = project.address1 {
            strCmpAddress = " \(add1)"
        }
        var strCmpAddress2 = ""
        if let add2 =  project.address2{
            strCmpAddress2 = ",\(add2)"
        }
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
        var strDescriptionValue = ""
        if let desc = project.project_description {
            strDescriptionValue = "\(desc)\n\n\n"
        }
        
        
        dateformater.dateFormat = "MMMM dd, YYYY"
        dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone
        now = DefaultDataManager.AppCurrentTime()
        
        let strSignature = "Signature Approved by\n"
        let strSignatureDate = "Date Approved: \(dateformater.string(from: now as Date))\n\n\n\n"
        
        var cmpName = ""
        if let cmp = companyInfo.companyName {
            cmpName = cmp
        }
        
        let strInspect = "The Inspection\n\n"
        let strInspectStr = "The basis of this report is an inspection of the common property areas of the scheme. This report is not an all encompassing report dealing with the scheme common areas from every aspect. It is a reasonable attempt to identify any obvious and significant defects upon common property areas of the scheme. This report is not a certificate of compliance with respect to any Act, Regulation, Ordinance or By-law. The report is not a structural report and should you require any advice of a structural nature we recommend our structural engineer be engaged.\n\nThe inspection of the common property of the scheme is a visual inspection only limited to those areas of the common property that are fully accessible and visible to the inspector at the time of inspection. The inspection did not include breaking apart, dismantling, removing or moving any element of the building and items located on the common property.\n\nThe report does not and cannot make comment upon: defects that may have been concealed; the assessment of which may rely on certain weather conditions; the presence or absence of timber pests; gas fittings; heritage concerns; site drainage; security concerns; detection and identification of illegal building work; durability of exposed finishes; the roof space and under floor space.\n\nThe inspector will identify and assess hazards relating to the static condition of the common property and then recommend remedial action or the introduction of a suitable control measure. This report is not an Asbestos Audit and no assessment of potential asbestos materials is made.\n\n"
        
        let strPurpose = "Purpose of Report\n\n"
        let  strPurposeSTR = "The purpose of this report is to increase awareness of risk and potential exposures to the property from OHS&E defects. The report is primarily intended solely for use by Building Manager and the Management Committee. Recommendations are listed where specific improvements are required to meet relevant standards.\n\n"
        
        let strDisclaimer = "Disclaimer\n\n"
        let  strDisclaimerStr = "This report has been prepared by \(cmpName) and is based on site inspections and information provided by site contact. In the circumstances, \(cmpName) nor any of its directors or employees give any warranty in relation to the accuracy or reliability of any information contained in this report. \(cmpName) disclaims all liability to any party (including any indirect or consequential loss or damage or loss of profits) in respect of or in consequence of anything done or omitted to be done by any party in reliance, whether in whole or partial, upon any information contained in this report. Any party who chooses to rely in any way upon the contents of this report does so at its own risk.\n\n"
        
        
        let strPriority = "Priority Key\n"
        let strPrioritySTR = "Urgency for rectifying the items listed below have been classified in this table from very low to extreme.\n"
        
        
        
        var mutableStr = String()
        
        if strContactName.characters.count > 0 {
            mutableStr.append(strContactNameBS)
            mutableStr.append(strContactName)
        }
        
        if strOrganization.characters.count > 0 {
            mutableStr.append(strOrganizationBS)
            mutableStr.append(strOrganization)
        }
        if strAddress1.characters.count > 0 {
            mutableStr.append(strAddress1BS)
            mutableStr.append(strAddress1)
        }
        if strAddress2.characters.count > 0 {
            mutableStr.append(strAddress2)
        }
        if strAddress3.characters.count > 0 {
            mutableStr.append(strAddress3)
        }
        if strPrepared.characters.count > 0 {
            mutableStr.append(strPreparedBS)
            mutableStr.append(strPrepared)
        }
        if strCompanyName.characters.count > 0 {
            mutableStr.append(strCompanyNameBS)
            mutableStr.append(strCompanyName)
        }
        
        if strCmpAddress.characters.count > 0 {
            mutableStr.append(strCmpAddressBS)
            mutableStr.append(strCmpAddress)
        }
        
        if strCmpAddress2.characters.count > 0 {
            mutableStr.append(strCmpAddress2)
        }
        
        if strCmpAddress3.characters.count > 0 {
            mutableStr.append(strCmpAddress3)
        }
        
        if strPhon.characters.count > 0 {
            mutableStr.append(strPhonBS)
            mutableStr.append(strPhon)
        }

        if strFax.characters.count > 0 {
            mutableStr.append(strFaxBS)
            mutableStr.append(strFax)
        }
        
        if strPhon.characters.count > 0 {
            mutableStr.append(strPhonBS)
            mutableStr.append(strPhon)
        }
        
        if strEmail.characters.count > 0 {
            mutableStr.append(strEmailBS)
            mutableStr.append(strEmail)
        }
        
        //3 rd leval
        //**************** issues list Start
        
        
        var mutableIssueStr = ""
        
        
        let sectionSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)//[NSSortDescriptor(key: "creationDate", ascending: true)]
        let sortDescriptors = [sectionSortDescriptor]
        
        
        let issueArray = (project.issues?.allObjects as! NSArray).sortedArray(using: sortDescriptors)
            
            
        
        let font14 = UIFont.init(name: "Helvetica", size: 14)
        let font17 = UIFont.init(name: "Helvetica", size: 17)
        let font14Bold =  UIFont.init(name: "Helvetica-Bold", size: 14)
        let font17Bold = UIFont.init(name: "Helvetica-Bold", size: 17)
        
        let titlStr = "\n\n\n\nTitle:\n"
        let DesStr = "\n\nDescription:\n"
        let ComStr = "\n\nComment:\n"
        let prioStr = "\n\nPriority:\n"
        
        if issueArray.count > 0 {
        
         for i in 0...(issueArray.count-1){
            
            let issue = issueArray[i] as! Issues
            
            mutableIssueStr.append(titlStr)
            var title = ""
            if let title1 = issue.title{
                title = title1
            }
            mutableIssueStr.append(title)
            mutableIssueStr.append(DesStr)
            var description = ""
            if let des = issue.issue_description{
                description = des
            }
            mutableIssueStr.append(description)
            mutableIssueStr.append(ComStr)
            var comment = ""
            if let com = issue.comment{
                comment = com
            }
            mutableIssueStr.append(comment)
           
            var priority = ""
            if let pri = issue.priority{
                priority = pri
            }
            mutableIssueStr.append(self.return_priority(priority))
            
        }
            
        }
       //****************** issues END
        
       var tempStr = "\(strTitle)\(mutableStr)"
        
        tempStr.append("\(strDescription)\(strDescriptionValue)\(strSignature)\(strSignatureDate)\(strInspect)\(strInspectStr)\(strPurpose)\(strPurposeSTR)\(strDisclaimer)\(strDisclaimerStr)\(strPriority)\(strPrioritySTR)\(mutableIssueStr)")
        
        var paragraphStyle :NSParagraphStyle = NSParagraphStyle.default
       // paragraphStyle.lineBreakMode =  .byTruncatingTail
       // paragraphStyle.alignment = .center
        
        let attributes = [ NSFontAttributeName: font17Bold! , NSParagraphStyleAttributeName:paragraphStyle ] as [String : Any]
        
        
        var docString :NSAttributedString = NSAttributedString(string: tempStr)
        //docString.
        
       // let data = docString data(ra)
        
        
        
        
        let range = NSMakeRange(0, docString.length)
        
       
        
        do {
            let textTSave = try docString.fileWrapper(from: range, documentAttributes: [NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType])
           
            let url = NSURL.fileURL(withPath: docFileName)
            
           try textTSave.write(to: url, options: FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
            
        } catch {
            print(error)
        }
        
        
        
        
        
      return docFileName
    }
    
    
    
    class func return_priority (_ priority:String)->String{
        var returnPeriority = ""
        
        if priority == "1.000000,0.000000,0.000000"{
            
            returnPeriority="High"
        }else if priority == "1.000000,1.000000,0.000000"{
            
            returnPeriority="Medium"
        }else if priority == "0.000000,1.000000,0.000000"{
            
            returnPeriority="Low"
        }else{
            returnPeriority="None"
        }
        
        
        return returnPeriority
        
    }
    
    
    
}
