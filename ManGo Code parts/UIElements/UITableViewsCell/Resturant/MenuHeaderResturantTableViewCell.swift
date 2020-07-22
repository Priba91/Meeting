//
//  MenuHeaderResturantTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/15/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class MenuHeaderResturantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populateWith(item: MenuSection){
        nameLbl.text = item.name
//        if self.isExpanded() {
//            expandBtn.setupTitleForKey(key: "hide")
//        }else{
//            expandBtn.setupTitleForKey(key: "show_all")
//        }
    }
}
