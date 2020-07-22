//
//  PaymentMethodTableViewCell.swift
//  ManGO
//
//  Created by Priba on 10/25/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        checkedImageView.setHalfCornerRadius()
        logoImageView.tintColor = .black
    }

    func populate(method: PaymentMethod){
        
        checkedImageView.isHidden = !method.isSelected
        
        if method.type == .cash {
            nameLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "cash_paying_method_title")
            logoImageView.image = UIImage(named: "cashIcon")
        }else{
            nameLbl.text = "**** **** **** \(method.card.last4)";
            
            switch method.card.brand {
            case "MASTERCARD":
                logoImageView.image = UIImage(named: "mastercard")
            case "AMERICANEXPRESS":
                logoImageView.image = UIImage(named: "americanExpressCard")
            case "VISA":
                logoImageView.image = UIImage(named: "visaCard")
            default:
                logoImageView.image = UIImage(named: "card")
            }
        }
        
    }

}
