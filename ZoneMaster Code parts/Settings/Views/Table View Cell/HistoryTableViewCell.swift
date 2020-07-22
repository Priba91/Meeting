//
//  HistoryTableViewCell.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 12/25/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var lightView: UIView!
    @IBOutlet var textTitleLabel: UILabel!
    @IBOutlet var forwardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setInit(title: String) {
        textTitleLabel.text = title
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        lightView.layer.cornerRadius = 10
        lightView.layer.masksToBounds = true
    }
}
