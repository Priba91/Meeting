//
//  RadioTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/14/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        radioBtn.setHalfCornerRadius()
    }
    
    func setSelected(selected: Bool){
        if selected{
            radioBtn.setImage(UIImage(named: "radio_button"), for: .normal)
            radioBtn.backgroundColor = .mangoGreen
        }else{
            radioBtn.setImage(nil, for: .normal)
            radioBtn.backgroundColor = .separatorColor        }
    }
    
    func setMultiSelected(selected: Bool){
        if selected{
            radioBtn.setImage(UIImage(named: "icCheck_small"), for: .normal)
            radioBtn.backgroundColor = .mangoGreen
        }else{
            radioBtn.setImage(nil, for: .normal)
            radioBtn.backgroundColor = .separatorColor        }
    }
}
