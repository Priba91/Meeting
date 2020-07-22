//
//  CheckTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/20/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        radioBtn.layer.cornerRadius = 3
        radioBtn.tintColor = .white
        
        radioBtn.layer.borderColor = UIColor.separatorColor.cgColor
        radioBtn.layer.borderWidth = 2
    }
    
    func setSelected(selected: Bool){
        if selected{
            radioBtn.setImage(UIImage(named: "icCheck_small"), for: .normal)
            radioBtn.backgroundColor = .mangoGreen
            radioBtn.layer.borderColor = UIColor.mangoGreen.cgColor
        }else{
            radioBtn.setImage(UIImage(named: ""), for: .normal)
            radioBtn.backgroundColor = .white
            radioBtn.layer.borderColor = UIColor.separatorColor.cgColor

        }
    }

}
