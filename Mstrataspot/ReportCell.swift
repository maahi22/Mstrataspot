//
//  ReportCell.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    
    // MARK: - Properties
    static let reuseIdentifier = "ReportCell"
    
    // MARK: -
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UITextView!
    @IBOutlet var imgView: UIImageView!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
