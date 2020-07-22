//
//  SettingsTableViewCell.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 11/15/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var textTitleLabel: UILabel!
    @IBOutlet var selectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setInit(title: String, imageName: String) {
        itemImageView.image = UIImage(named: imageName)
        textTitleLabel.text = title
    }
}
 
