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
        
        let font12 = UIFont.init(name: "Helvetica", size: 14)
        
        let font14 = UIFont.init(name: "Helvetica", size: 14)
        let font17 = UIFont.init(name: "Helvetica", size: 17)
        let font14Bold =  UIFont.init(name: "Helvetica-Bold", size: 14)
        let font17Bold = UIFont.init(name: "Helvetica-Bold", size: 17)
        
        
        
        
        var boxHeight :CGFloat = 235
        
        var minBoxHeight:CGFloat = 235
        var currentY:CGFloat = 0.0
        
        
        var dateformater = DateFormatter()
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
        
        currentY  = 45.0
        
        var currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
       
        //Draw image
        if project.projectLogoImage != nil  {
            
            let demoImage =  UIImage(data:project.value(forKey: "projectLogoImage") as! Data,scale:1.0)
            
            var imageHeight :CGFloat = (demoImage?.size.height)!
            var imageWidth:CGFloat = (demoImage?.size.width)!
            
            if imageHeight > 156
            {
                imageWidth = (imageWidth / imageHeight) * 156.0
                imageHeight = 156.0
                
                
                if imageWidth > 612 {
                    imageWidth = 612
                    
                }
                
            }
            
            let rect = CGRect (x: 200.0, y: currentY, width: imageWidth, height: imageHeight)
            demoImage?.draw(in:rect )
            currentY = currentY + 156 + 10
            
        }else{
            currentY = currentY + 156 + 10
        }//Image draw end
        
        
        var textToDraw = ""
        if let title = project.title {
            textToDraw = "\(title.uppercased())\n\n"
        }
        
        
        var maxSize = CGSize(width: pdfPageWidth - 4*kBorderInset-2*kMarginInset , height:  pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
            
        
        
        
        var stringSize =  (textToDraw as NSString).boundingRect(with: maxSize,
                                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                            attributes: [NSFontAttributeName:font14 as Any],
                                                                            context: nil).size
        
        var renderingRect = CGRect(x: CGFloat(200.0), y: currentY+10, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset), height: stringSize.height)
        
        textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14 as Any])
        
        currentY = currentY + 10 + stringSize.height
       
        var listTitle = NSMutableArray()
        var listInfo = NSMutableArray()
        
        
    
        if let name = project.clientName {
            listTitle.add("Contact Name:")
            listInfo.add(name)
        }
        
        if let name = project.organizationName {
            listTitle.add("Organization Name:")
            listInfo.add(name)
        }
        if let name = project.clientAddress1 {
            listTitle.add("Address")
            listInfo.add(name)
        }
        if let name = project.clientAddress2 {
            listTitle.add("")
            listInfo.add(name)
        }
        
        
        if  project.clientCity != nil || project.clientCity != nil || project.clientCity != nil || project.clientCity != nil{
            
            var tempStr = ""
            
            if let city = project.clientCity {
               tempStr.appending(city)
            }
            
            if let state = project.clientState {
                if tempStr != ""{
                    tempStr = "\(tempStr),\(state) "
                }else{
                    tempStr = "\(state)"
                }
            }
            
            if let zip = project.clientZip {
                if tempStr != ""{
                    tempStr = "\(tempStr),\(zip) "
                }else{
                    tempStr = "\(zip)"
                }
            }
            
            listTitle.add("")
            listInfo.add(tempStr)
            
            
        }
        
        listTitle.add("")
        listInfo.add("Australia")
        
        
        
        var sectionSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        var sortDescriptors = [sectionSortDescriptor]
        var issueArray = (project.issues?.allObjects as! NSArray).sortedArray(using: sortDescriptors)
        
        if listTitle.count > 0 {
            
            for i in 0...(listTitle.count-1){
                
                textToDraw = listInfo [i] as! String
                
               // let maxSize = CGSize(width: 450.0 , height:  pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
                
                
              let  mSize = CGSize(width: 450, height: pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
                
                stringSize =  (textToDraw as NSString).boundingRect(with: mSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font14 as Any],
                                                                    context: nil).size
                
                
               /* if currentY + stringSize.height >= pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset {
                    
                    UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
                    currentPage = currentPage + 1
                    let currentContext = UIGraphicsGetCurrentContext()
                    
                    
                    currentY = kBorderInset + kMarginInset + 15.0
                    
                }*/
                
                
                
                currentY = currentY  + 20.0
                
                renderingRect = CGRect(x: CGFloat(200.0), y: currentY+50, width: 450.0 , height: stringSize.height)
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14 as Any])
                
                
            
                let textHeight = stringSize.height
               textToDraw = listTitle[i] as! String
                
                
                let  newSize = CGSize(width: 200, height: pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
                
                stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font14 as Any],
                                                                    context: nil).size

                renderingRect = CGRect(x: CGFloat(50.0), y: currentY, width: 150.0 , height: stringSize.height)
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14 as Any])
                
                
                /*let val = i + 1
                
                if  val < listTitle.count && (listTitle[val] as! String).characters.count > 0 {
                    currentY = currentY + textHeight
                }else{
                   currentY = currentY + textHeight
                }*/
                let value = listTitle[i] as! String
                if (i) < listTitle.count && value.characters.count > 0 {
                    currentY += 0 + textHeight
                    
                }else{
                    currentY += textHeight
                }
                
            }
            
        }
        
        
        if(currentY < pageSize.height/2 ){
            currentY = pageSize.height/2
        }
        currentY += 10;
        
        
//********************Company Logo
        
        
        if  companyInfo != nil &&  companyInfo.value(forKey: "companyLogoImage")  != nil
        {
            let demoImage =  UIImage(data:companyInfo.value(forKey: "companyLogoImage") as! Data,scale:1.0)
            
            var imageHeight :CGFloat = (demoImage?.size.height)!
            var imageWidth:CGFloat = (demoImage?.size.width)!
            
            if imageHeight > 156
            {
                imageWidth = (imageWidth / imageHeight) * 156.0
                imageHeight = 156.0
                
                
                if imageWidth > 612 {
                    imageWidth = 612
                    
                }
                
            }
            
            let val:CGFloat = CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
            
            if (currentY + 156 >= val) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
                currentPage = currentPage + 1
                let currentContext = UIGraphicsGetCurrentContext()
                currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                currentY = CGFloat(kBorderInset + kMarginInset + 15)
  
            }
            
            let rect = CGRect (x: 200.0, y: currentY, width: imageWidth, height: imageHeight)
            demoImage?.draw(in:rect )
            currentY = currentY + 156 + 10
            
            
        }else{
            currentY = currentY + 156 + 10
        }
        
        
        listTitle.removeAllObjects()
        listInfo.removeAllObjects()
        
        if let name = project.employeeName {
            listTitle.add("Prepared By:")
            listInfo.add(name)
        }
        
        if let name = project.companyName {
            listTitle.add("Company Name")
            listInfo.add(name)
        }
        if let name = project.address1 {
            listTitle.add("Address")
            listInfo.add(name)
        }
        if let name = project.address2 {
            listTitle.add("")
            listInfo.add(name)
        }
        
        if  project.city != nil || project.state != nil || project.zip != nil {
            
            var tempStr = ""
            
            if let city = project.city {
                tempStr.appending(city)
            }
            
            if let state = project.state {
                if tempStr != ""{
                    tempStr = "\(tempStr),\(state) "
                }else{
                    tempStr = "\(state)"
                }
            }
            
            if let zip = project.zip {
                if tempStr != ""{
                    tempStr = "\(tempStr),\(zip) "
                }else{
                    tempStr = "\(zip)"
                }
            }
            
            listTitle.add("")
            listInfo.add(tempStr)
        }
        
        listTitle.add("")
        listInfo.add("Australia")
        
        if let name = companyInfo.phone {
            listTitle.add("Phone")
            listInfo.add(name)
        }
        if let name = companyInfo.fax {
            listTitle.add("Fax")
            listInfo.add(name)
        }
        if let name = companyInfo.email {
            listTitle.add("Email")
            listInfo.add(name)
        }
        if let name = companyInfo.webSite {
            listTitle.add("Web")
            listInfo.add(name)
        }
        
        
        
        
        
        
        if listTitle.count > 0 {
            for i in 0...(listTitle.count-1){
             
                textToDraw = listInfo[i] as! String
                
                var  mSize = CGSize(width: 450, height: pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
                
                stringSize =  (textToDraw as NSString).boundingRect(with: mSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font14Bold as Any],
                                                                    context: nil).size
                
                var val:CGFloat = CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)
                
                if (currentY + stringSize.height >= val) {
                    
                    UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
                    currentPage = currentPage + 1
                    let currentContext = UIGraphicsGetCurrentContext()
                    currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                    currentY = CGFloat(kBorderInset + kMarginInset + 15)
                    
                }
                
                renderingRect = CGRect(x: CGFloat(200.0), y: currentY, width: 150.0 , height: stringSize.height)
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
                
                
               
                
                
                
                
                
                let textHeight = stringSize.height
                textToDraw = listTitle[i] as! String
                
                mSize = CGSize(width: CGFloat(150.0), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
                
                stringSize =  (textToDraw as NSString).boundingRect(with: mSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font14 as Any],
                                                                    context: nil).size
                
                renderingRect = CGRect(x: CGFloat(50.0), y: currentY, width: 150.0 , height: stringSize.height)
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
                
                
                
               let  value = listTitle[i] as! String
                
                
                if (i) < listTitle.count && value.characters.count > 0 {
                    currentY += 0 + textHeight
                    
                }else{
                    currentY += textHeight
                }
                
                
            }
        }
        
        
        
        // Project Description
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
        currentPage = currentPage + 1
        currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        currentY = CGFloat(kBorderInset + kMarginInset + 15)
        
        
        textToDraw = "Project Description"
        
        var  newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        
        stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font14Bold as Any],
                                                            context: nil).size
        

        let textToDraw1 = project.project_description as! String
        
        let stringSize1 = (textToDraw1 as! NSString).boundingRect(with: CGSize(width: pdfPageWidth - 4*kBorderInset-2*kMarginInset, height: pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset),
                                                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                attributes: [NSFontAttributeName:font12 as Any],
                                                                context: nil).size
        
        
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
        
        currentY += 10 + stringSize.height
        
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth -  4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        textToDraw1.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        
        currentY += 10 + stringSize1.height
        
        //***************************   Signature
        
        if   project.value(forKey: "clientSignatureImage")  != nil
        {
            let demoImage =  UIImage(data:project.value(forKey: "clientSignatureImage") as! Data,scale:1.0)
            
            var imageHeight :CGFloat = (demoImage?.size.height)!
            var imageWidth:CGFloat = (demoImage?.size.width)!
            
            if imageHeight > 156
            {
                imageWidth = (imageWidth / imageHeight) * 156.0
                imageHeight = 156.0
                
                
                if imageWidth > 612 {
                    imageWidth = 612
                    
                }
                
            }
            
            var hightNeeded:CGFloat = 100.0
            
            textToDraw = "Approved by             "
            
              newSize = CGSize(width: CGFloat(((pdfPageWidth - 4*kBorderInset)*10)/10 - 5), height: CGFloat(boxHeight - 5.0))
            

            
            
            let stringSize = (textToDraw as NSString).boundingRect(with:newSize,
                                                                      options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                      attributes: [NSFontAttributeName:font12 as Any],
                                                                      context: nil).size
            hightNeeded += stringSize.height + 15
            
            if (currentY + hightNeeded >= CGFloat( pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset)) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
                currentPage = currentPage + 1
                let currentContext = UIGraphicsGetCurrentContext()
                currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                currentY = CGFloat(kBorderInset + kMarginInset + 15)
                
            }
            
            let maxY = CGFloat (pdfPageHEIGHT) - CGFloat((CGFloat(2*kBorderInset) - CGFloat(2*kMarginInset)) - CGFloat(hightNeeded))
            
            
            renderingRect = CGRect(x: CGFloat(kBorderInset * 2 ), y: CGFloat(currentY + CGFloat(ApprovADDY) + 10), width: CGFloat(pdfPageWidth/3 - 20) , height: stringSize.height)
            textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
            
           
            
            
            let rect = CGRect (x: 0.0, y: currentY + CGFloat(ApprovADDY) + stringSize.height + 15, width: imageWidth, height: imageHeight)
            demoImage?.draw(in:rect )
            currentY += hightNeeded
            
            
        }
        
        
        //Current Date
        
        dateformater.dateFormat = "MMMM dd, YYYY"
        dateformater.timeZone = DefaultDataManager.AppTimeZone() as TimeZone!
        now = DefaultDataManager.AppCurrentTime()
        
        textToDraw = "Date Approved: \(dateformater.string(from: now as Date))"
        
          newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        
        stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font14Bold as Any],
                                                            context: nil).size

        
        if (currentY + stringSize.height >= CGFloat(pdfPageHEIGHT - (2*kBorderInset - 2*kMarginInset))) {
            
            UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
            currentPage = currentPage + 1
            let currentContext = UIGraphicsGetCurrentContext()
            currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            currentY = CGFloat(kBorderInset + kMarginInset + 15)
            
        }
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: (currentY + CGFloat(ApprovADDY)), width: CGFloat(pdfPageWidth - (4*kBorderInset - 2*kMarginInset)) , height: stringSize.height)
        textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        currentY += 20 + stringSize.height
        //***************************   Signature END
        
        currentPage = currentPage + 1

        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
        currentPage = currentPage + 1
        currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        currentY = CGFloat(kBorderInset + kMarginInset + 15)
        
        
        var cmpName = ""
        if let cmp = companyInfo.companyName {
            cmpName = cmp
        }
        let strInspect = "The Inspection"
        let strInspectStr = "The basis of this report is an inspection of the common property areas of the scheme. This report is not an all encompassing report dealing with the scheme common areas from every aspect. It is a reasonable attempt to identify any obvious and significant defects upon common property areas of the scheme. This report is not a certificate of compliance with respect to any Act, Regulation, Ordinance or By-law. The report is not a structural report and should you require any advice of a structural nature we recommend our structural engineer be engaged.\n\nThe inspection of the common property of the scheme is a visual inspection only limited to those areas of the common property that are fully accessible and visible to the inspector at the time of inspection. The inspection did not include breaking apart, dismantling, removing or moving any element of the building and items located on the common property.\n\nThe report does not and cannot make comment upon: defects that may have been concealed; the assessment of which may rely on certain weather conditions; the presence or absence of timber pests; gas fittings; heritage concerns; site drainage; security concerns; detection and identification of illegal building work; durability of exposed finishes; the roof space and under floor space.\n\nThe inspector will identify and assess hazards relating to the static condition of the common property and then recommend remedial action or the introduction of a suitable control measure. This report is not an Asbestos Audit and no assessment of potential asbestos materials is made."
        
        let strPurpose = "Purpose of Report"
        let  strPurposeSTR = "The purpose of this report is to increase awareness of risk and potential exposures to the property from OHS&E defects. The report is primarily intended solely for use by Building Manager and the Management Committee. Recommendations are listed where specific improvements are required to meet relevant standards."
        
        let strDisclaimer = "Disclaimer\n\n"
        let  strDisclaimerStr = "This report has been prepared by \(cmpName) and is based on site inspections and information provided by site contact. In the circumstances, \(cmpName) nor any of its directors or employees give any warranty in relation to the accuracy or reliability of any information contained in this report. \(cmpName) disclaims all liability to any party (including any indirect or consequential loss or damage or loss of profits) in respect of or in consequence of anything done or omitted to be done by any party in reliance, whether in whole or partial, upon any information contained in this report. Any party who chooses to rely in any way upon the contents of this report does so at its own risk.\n\n"
        
        
        let strPriority = "Priority Key"
        let strPrioritySTR = "Urgency for rectifying the items listed below have been classified in this table from very low to extreme."
        
        //************** strInspect
        
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strInspect as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font14Bold as Any],
                                                            context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strInspect.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
        currentY += 10 + stringSize.height
        
        
        //********** strInspectStr
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strInspectStr as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font12 as Any],
                                                            context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strInspectStr.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        currentY += 20 + stringSize.height
        
        
        //****************strPurpose
        
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strPurpose as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font14Bold as Any],
                                                            context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strPurpose.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
        currentY += 10 + stringSize.height
        
        
        //****************strPurposeSTR
        
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strPurposeSTR as NSString).boundingRect(with: newSize,
                                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                            attributes: [NSFontAttributeName:font12 as Any],
                                                            context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strPurposeSTR.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        currentY += 20 + stringSize.height
        
        
        //****************strDisclaimer
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strDisclaimer as NSString).boundingRect(with: newSize,
                                                               options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                               attributes: [NSFontAttributeName:font14Bold as Any],
                                                               context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strDisclaimer.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
        currentY += 10 + stringSize.height
        
        //****************strDisclaimerStr
        
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strDisclaimerStr as NSString).boundingRect(with: newSize,
                                                               options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                               attributes: [NSFontAttributeName:font12 as Any],
                                                               context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strDisclaimerStr.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        currentY += 20 + stringSize.height
        
        let rightImagY = currentY + 10
        
        //****************strPriority
        newSize = CGSize(width: CGFloat(pdfPageWidth - 4*kBorderInset-2*kMarginInset), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strPriority as NSString).boundingRect(with: newSize,
                                                                  options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                  attributes: [NSFontAttributeName:font14Bold as Any],
                                                                  context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(pdfPageWidth - 4*kBorderInset - 2*kMarginInset) , height: stringSize.height)
        strPriority.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font14Bold as Any])
        currentY += 10 + stringSize.height
        
        //****************strPrioritySTR
        newSize = CGSize(width: CGFloat(250.0), height: CGFloat(pdfPageHEIGHT - 2*kBorderInset - 2*kMarginInset))
        stringSize =  (strPrioritySTR as NSString).boundingRect(with: newSize,
                                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                             attributes: [NSFontAttributeName:font12 as Any],
                                                             context: nil).size
        
        renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(250) , height: stringSize.height)
        strPrioritySTR.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
        currentY +=  stringSize.height
        
        
        
        //****** Draw image
        var demoImage = UIImage(named: "PriorityImage.jpg")
        var rect = CGRect (x:CGFloat(kBorderInset * 2 + kMarginInset), y: currentY , width:  CGFloat(200.0), height: CGFloat(120.0))
        demoImage?.draw(in:rect )
    
        //***** Draw 2nd image
         demoImage = UIImage(named: "PriorityGraph.jpg")
         rect = CGRect (x:CGFloat(kBorderInset * 2 + kMarginInset + 250), y: rightImagY , width:  CGFloat(310.0), height: CGFloat(220.0))
        demoImage?.draw(in:rect )
        
        
        
        
        
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height), nil)
        currentPage = currentPage + 1
        currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        currentY = CGFloat(kBorderInset + kMarginInset + 15)
        
        //******************Issues
        var sectionSortDescriptor1 = NSSortDescriptor(key: "creationDate", ascending: true)
        var sortDescriptors1 = [sectionSortDescriptor1]
        var data = (project.issues?.allObjects as! NSArray).sortedArray(using: sortDescriptors1)

        
        var StartingYAXIS = CGFloat(0.0)
        var TextHeight = CGFloat(0.0)
        var imgStatus:Int = 0
        
        if data.count > 0 {
            for i in 0...(data.count-1){
                
                let issue = data[i] as! Issues
                boxHeight = minBoxHeight
                TextHeight = CGFloat(150.0)
                imgStatus = 0
                
                
                
                
                
                StartingYAXIS = currentY
                var totalHightNeeded:CGFloat = 0.0
                
                textToDraw = issue.title!
                
                
                
                newSize = CGSize(width: CGFloat(pdfThird_Width - 60), height: CGFloat(boxHeight - 5))
                stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                        attributes: [NSFontAttributeName:font12 as Any],
                                                                        context: nil).size
                totalHightNeeded += CGFloat( CGFloat(stringSize.height) + CGFloat(10.0))
                
                
              
                let currentContext = UIGraphicsGetCurrentContext()
                currentContext?.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                
                var titleHeight:CGFloat = 0.0
                
                
                
                
                renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + kMarginInset), y: currentY, width: CGFloat(250) , height: stringSize.height)
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                currentY +=  stringSize.height

                
                //*************************  CALCULATE TEXT HEIGHT FOR COLOR
                var titHeight:CGFloat = 0.0
                var descHeight:CGFloat = 0.0
                var comHeight:CGFloat = 0.0
                var colorHeight:CGFloat = 0.0
                
                if let title = issue.title {
                    
                    textToDraw = title
                    newSize = CGSize(width: CGFloat(pdfThird_Width - 60), height: CGFloat(boxHeight - 5))
                    stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                        attributes: [NSFontAttributeName:font12 as Any],
                                                                        context: nil).size
                
                
                    renderingRect = CGRect(x: CGFloat(kBorderInset * 2 + 10), y: titHeight + titleHeight + 5, width: CGFloat(pdfThird_Width-60) , height: stringSize.height)
                    strPrioritySTR.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                    currentY +=  stringSize.height
                
                
                }
                
                var imageY1 : CGFloat = titHeight + stringSize.height + 15;
                var   priorityY1: CGFloat = 0.0
            
               //**********************************  issue image drawing
                if   issue.value(forKey: "issueImage")  != nil
                {
                    
                    imgStatus=1
                    let demoImage =  UIImage(data:issue.value(forKey: "issueImage") as! Data,scale:1.0)
                    var imageHeight :CGFloat = (demoImage?.size.height)!
                    var imageWidth:CGFloat = (demoImage?.size.width)!
                    
                    let wid:CGFloat = CGFloat(((pdfPageWidth - (4*kBorderInset) - 10)*4)) / CGFloat(10)  - CGFloat(10)
                    
                    //CGFloat((((pdfPageWidth - 4*kBorderInset - 10)*4) / CGFloat(10.0) ) - CGFloat(10.0))
                    
                    if imageWidth > wid
                    {
                        
                        
                        imageHeight = (imageHeight/imageWidth)*wid
                        imageWidth = wid
                    }
                    
                    if(imageHeight > boxHeight - 10)
                    {
                        imageWidth = (imageWidth/imageHeight)*(boxHeight - 10)
                        imageHeight = boxHeight - 10
                    }
                    
                    priorityY1=imageY1+15 + imageHeight;
                    
                    
                    
                    
                    
                  
                    
                    
                }else{
                    imgStatus=0;
                    priorityY1 = titHeight + titleHeight + 15
                }
//**********************************  issue image drawing Ended
                 if let priority = issue.priority {
                    
                    let color = UIColor.hexStringToUIColor(hex: priority)
                    
                    textToDraw = "Priority"
                    newSize = CGSize(width: CGFloat(90), height: CGFloat(boxHeight - titleHeight - 5))
                    stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                        attributes: [NSFontAttributeName:font12 as Any],
                                                                        context: nil).size
                    renderingRect = CGRect(x: CGFloat((kBorderInset * 2) + 10), y: priorityY1, width: CGFloat(90) , height: stringSize.height)
                    textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                    
                    
                    
                    //drawPriorityBox
                    
                    
                    
                    
                    
                    
                }
                
                currentY = priorityY1 + stringSize.height + 50
                
                
                
                
                var   DescriptionYAxis:CGFloat = CGFloat( currentY + titleHeight + 5.0)
                var   CommentYAxis:CGFloat = CGFloat( currentY + titleHeight + 5.0)
                
                
                
                
              //********************** Issues Description
                textToDraw = "Description"
                newSize = CGSize(width: CGFloat(pdfThird_Width-30), height: CGFloat(pdfPageHEIGHT))
                stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font12 as Any],
                                                                    context: nil).size
                renderingRect = CGRect(x: CGFloat(CGFloat(pdfThird_Width) + 25.0), y: DescriptionYAxis, width: CGFloat(CGFloat(pdfThird_Width) - 30.0) , height: stringSize.height)
                var  desHeight: CGFloat = DescriptionYAxis + stringSize.height
                
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                
                
                titleHeight += stringSize.height
                
                
                if let desc = issue.issue_description {
                    textToDraw = desc
                    newSize = CGSize(width: CGFloat(pdfThird_Width-30), height: CGFloat(pdfPageHEIGHT))
                    stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                        attributes: [NSFontAttributeName:font12 as Any],
                                                                        context: nil).size
                    renderingRect = CGRect(x: CGFloat(CGFloat(pdfThird_Width) + 25.0), y: DescriptionYAxis, width: CGFloat(CGFloat(pdfThird_Width) - 30.0) , height: stringSize.height)
                
                    textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
               
                    titleHeight += stringSize.height + 10
                }
                
                if(currentY < CGFloat(desHeight + titleHeight )){
                    currentY = desHeight + titleHeight
                }
                
                
                //********************* Issues Comment
                
                textToDraw = "Comment"
                newSize = CGSize(width: CGFloat(pdfThird_Width-30), height: CGFloat(pdfPageHEIGHT))
                stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font12 as Any],
                                                                    context: nil).size
                renderingRect = CGRect(x: CGFloat((CGFloat(pdfThird_Width)*2)+25), y: CommentYAxis, width: CGFloat(CGFloat(pdfThird_Width) - 30.0) , height: stringSize.height)
                var  commentHeight: CGFloat = CommentYAxis + stringSize.height
                
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                
                titleHeight += stringSize.height

                
               if let comnt = issue.comment {
                
                textToDraw = comnt
                newSize = CGSize(width: CGFloat(pdfThird_Width - 45), height: CGFloat(pdfPageHEIGHT))
                stringSize =  (textToDraw as NSString).boundingRect(with: newSize,
                                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                    attributes: [NSFontAttributeName:font12 as Any],
                                                                    context: nil).size
                renderingRect = CGRect(x: CGFloat((pdfThird_Width*2)+25), y: commentHeight, width: CGFloat(CGFloat(pdfThird_Width) - CGFloat(45.0)) , height: stringSize.height)
                
                textToDraw.draw(in: renderingRect, withAttributes: [NSFontAttributeName:font12 as Any])
                
                titleHeight += stringSize.height + 10
                
                }
                
                
                if currentY < CGFloat(CGFloat(commentHeight) + CGFloat(titleHeight))
                {
                    currentY = CGFloat(commentHeight + titleHeight)
                }
                
                
                
                
                
                
                
                
                
                
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        UIGraphicsEndPDFContext()
        return pdfFileName;
    }
    
    
    
    
    
    func drawPriorityBox(_ point :CGFloat , colrHexcode:String) {
        
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
