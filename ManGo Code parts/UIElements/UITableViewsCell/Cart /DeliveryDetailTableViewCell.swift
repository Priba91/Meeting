//
//  OrderItemTableViewCell.swift
//  ManGO
//
//  Created by Priba on 8/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class DeliveryDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        iconImageView.tintColor = .lightGray
    }
    
    func populateWith(order: OrderModel, row: Int){
        
        switch row {
        case 0:
            titleLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "cargo_delivery")
            descLbl.text = "\(order.distance)" + " " + LanguageManager.sharedInstance.getStringForKey(key: "delivery_distance")
            leftLabel.setupTitleForKey(key: "free")
            iconImageView.image = UIImage(named: "icDirectionsBike")
            
        case 1:
            titleLbl.text = order.address.street + " " + order.address.streetNumber
            descLbl.text = order.address.phone
            leftLabel.setupTitleForKey(key: "change")
            
            switch order.address.type {
            case .home:
                iconImageView.image = UIImage(named: "icHome")?.withRenderingMode(.alwaysTemplate)
            case .work:
                iconImageView.image = UIImage(named: "icWork")?.withRenderingMode(.alwaysTemplate)
            case .other:
                iconImageView.image = UIImage(named: "icRoom")?.withRenderingMode(.alwaysTemplate)
                
            }            
            
        case 3:
            
            if DataManager.sharedInstance.logedUser.defaultPaymentMethod.type == .cash {
                
                titleLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "cash_paying_method_title")
                descLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "cash_paying_method_desc")
                iconImageView.image = UIImage(named: "cashIcon")
                
            }else{
                
                titleLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "card_paying_method_title")
                descLbl.text = "**** **** **** \(DataManager.sharedInstance.logedUser.defaultPaymentMethod.card.last4)";
                iconImageView.image = UIImage(named: "card_tint")
            }
            
            leftLabel.setupTitleForKey(key: "change")
            
        case 4:
            titleLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "promo_code")
            descLbl.text = LanguageManager.sharedInstance.getStringForKey(key: "promo_code_desc")
            leftLabel.text = ""
            iconImageView.image = UIImage(named: "icPayment")
            
            
        default:
            return
        }
        
    }
    
}
