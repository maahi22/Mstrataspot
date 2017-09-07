//
//  ProjectListCell.swift
//  Mstrataspot
//
//  Created by Maddy on 9/7/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class ProjectListCell: UITableViewCell {

    
     // MARK: - Properties
    static let reuseIdentifier = "ProjectListCell"
    
    // MARK: -
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UITextView!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgViewHolder: UIImageView!
    @IBOutlet var imageIcon: UIImageView!
    
    var rowIndex = 0
    var hasDeleteOption = false
    
    
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
