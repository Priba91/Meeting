//
//  RadioTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/14/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class RadioItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var curencyLbl: UILabel!
    @IBOutlet weak var cellBtn: UIButton!
    
    var selectedRadioImage = UIImage(named: "radio_button")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        radioBtn.setHalfCornerRadius()
    }
    
    func populate(item: AdditionMenuItemModel) {
        nameLbl.text = item.name
        curencyLbl.text = ""
        setSelected(selected: item.selected)
    }
    
    func populate(item: AditionItemModel) {
        nameLbl.text = item.name
        curencyLbl.text = String(item.getPriceString())
        setSelected(selected: item.selected)
    }
    
    func populate(item: MenuItem) {
        nameLbl.text = item.name
        curencyLbl.text = String(item.getPriceString())
        setSelected(selected: item.selected)
    }
    
    func setSelectedImage(singleSelection: Bool){
        if singleSelection{
            selectedRadioImage = UIImage(named: "radio_button")
        }else{
            selectedRadioImage = UIImage(named: "icCheck_small")
        }
        radioBtn.setImage(selectedRadioImage, for: .normal)
    }
    
    func setSelected(selected: Bool){
        if selected{
            radioBtn.setImage(selectedRadioImage, for: .normal)
            radioBtn.backgroundColor = .mangoGreen
        }else{
            radioBtn.setImage(nil, for: .normal)
            radioBtn.backgroundColor = .separatorColor
            
        }
    }
}

extension Array where Element: MenuItem {
    
    func deselectAll() {
        for element in self {
            element.selected = false
        }
    }
}
