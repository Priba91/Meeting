//
//  HistoryHeaderView.swift
//  PhysioZone
//
//  Created by Nikola Popovic on 12/25/19.
//  Copyright © 2019 com.newtec-solutions.physiosone. All rights reserved.
//

import UIKit

class HistoryHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var textTitleLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    public func setInit(text: String) {
        textTitleLabel.text = text
        self.backgroundColor = .clear
    }
}
