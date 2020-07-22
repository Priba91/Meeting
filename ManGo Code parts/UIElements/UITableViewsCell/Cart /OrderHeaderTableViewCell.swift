//
//  OrderHeaderTableViewCell.swift
//  ManGO
//
//  Created by Priba on 8/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class OrderHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    func populate(strKey: String){
        titleLbl.setupTitleForKey(key: strKey)
    }

}
