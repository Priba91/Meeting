//
//  CreditCardTableViewCell.swift
//  ManGO
//
//  Created by Priba on 10/24/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents

class CreditCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: ShadowMaterialView!
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var lastFourDigitsLbl: UILabel!
    @IBOutlet weak var exparationLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        backView.layer.cornerRadius = 12
        shadowView.layer.cornerRadius = 12
    }

    func populate(card: CardModel){
        
        lastFourDigitsLbl.text = card.last4
        exparationLbl.text = card.expiration
        fullNameLbl.text = card.fullName

        if card.isDefault {
            shadowView.setShadowColor(.mangoGreen, for: .normal)
            backView.layer.borderWidth = 1.5
            backView.layer.borderColor = UIColor.mangoGreen.cgColor
        }else{
            shadowView.setShadowColor(.lightGray, for: .normal)
            backView.layer.borderColor = UIColor.white.cgColor
        }
        
        switch card.brand {
        case "MASTERCARD":
            brandLogo.image = UIImage(named: "mastercard")
        case "AMERICANEXPRESS":
            brandLogo.image = UIImage(named: "americanExpressCard")
        case "VISA":
            brandLogo.image = UIImage(named: "visaCard")
        default:
            brandLogo.image = UIImage(named: "card")
        }
        
    }

}
