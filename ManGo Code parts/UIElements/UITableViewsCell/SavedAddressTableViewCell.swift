//
//  SavedAddressTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/21/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class SavedAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        iconView.setHalfCornerRadius()
        editBtn.setHalfCornerRadius()
    }

    func populate(address: AddressModel){
        switch address.type {
        case .home:
            iconView.setImage(UIImage(named: "icHome")!, for: .normal)
            
        case .work:
            iconView.setImage(UIImage(named: "icWork")!, for: .normal)

        case .other:
            iconView.setImage(UIImage(named: "icRoom")!, for: .normal)
        }
        
        iconView.tintColor = address.selected ? UIColor.mangoGreen : UIColor.lightGray
        
        titleLbl.text = address.getFullStreet()
        phoneLbl.text = address.phone
    }

}
