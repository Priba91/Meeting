//
//  ResturantTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import SDWebImage

class ResturantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: MDCCard!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var rateIcon: UIButton!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var addMoreBtn: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        backView.layer.cornerRadius = 8
        shadowView.cornerRadius = 8
        shadowView.setShadowElevation(ShadowElevation.init(rawValue: 3), for: .normal)
        
        msgLbl.setupTitleForKey(key: "min_delivery_alert_message")
        addMoreBtn.setupTitleForKey(key: "add_more", uppercased: true)
    }
    
    func populate(resturant: ResturantModel, showDeliveryAlert: Bool){
        self.avatarImageView.sd_setImage(with: URL(string: resturant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        nameLbl.text = resturant.name
        typeLbl.text = resturant.foodType
        
        favoriteBtn.tintColor = resturant.isFavorite ? UIColor.mangoGreen : UIColor.lightGray
        
        paymentLbl.text = "\(resturant.minDeliveryPrice)"
        rateLbl.text = "\(resturant.averageRate) (\(resturant.numberOfRates))"
        timeLbl.text = "\(resturant.openTime) - \(resturant.closeTime)"
        
        if resturant.averageRate < 2.5 {
            rateIcon.tintColor = .lightGray
        }
        
        if showDeliveryAlert {
            alertView.isHidden = false
            alertViewHeight.constant = 56
            
            
            titleLbl.text = "\(LanguageManager.sharedInstance.getStringForKey(key: "min_delivery_alert_title")) \(String.init(format: "%2.f", resturant.minDeliveryPrice)) \(DataManager.sharedInstance.currency)"
        }else{
            alertView.isHidden = true
            alertViewHeight.constant = 0
        }
    }
    
    
}

