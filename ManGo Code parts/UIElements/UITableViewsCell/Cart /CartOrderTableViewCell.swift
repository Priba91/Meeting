//
//  CartOrderTableViewCell.swift
//  ManGO
//
//  Created by Priba on 8/14/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents
import SDWebImage

class CartOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: MDCCard!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var rateSmallIcon: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var rateIcon: UIImageView!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var previewBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        backView.layer.cornerRadius = 8
        shadowView.cornerRadius = 8
        shadowView.setShadowElevation(ShadowElevation.init(rawValue: 4), for: .normal)
        
        avatarImageView.roundCorners([.topLeft], radius: 8)
        
        rightBtn.setHalfCornerRadius()
        rateIcon.setHalfCornerRadius()
        
        detailsLbl.setupTitleForKey(key: "details")
        
        statusLbl.setHalfCornerRadius()
        
    }
    
    func populate(order: OrderModel){
        self.avatarImageView.sd_setImage(with: URL(string: order.restaurant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        nameLbl.text = order.restaurant.name
        typeLbl.text = order.restaurant.foodType
        
        favoriteBtn.tintColor = order.restaurant.isFavorite ? UIColor.mangoGreen : UIColor.lightGray
        
        paymentLbl.text = "\(order.restaurant.minDeliveryPrice)"
        rateLbl.text = "\(order.restaurant.averageRate)/\(order.restaurant.numberOfRates)"
        timeLbl.text = "\(order.restaurant.openTime) - \(order.restaurant.closeTime)"

        priceLbl.text = order.getPriceString()

        addressLbl.text = order.address.street
        statusLbl.text = order.getStatusString()

        paymentLbl.text = "\(order.restaurant.minDeliveryPrice)"
        rateLbl.text = "\(order.restaurant.averageRate)/\(order.restaurant.numberOfRates)"
        timeLbl.text = "\(order.restaurant.openTime) - \(order.restaurant.closeTime)"
        
        if order.restaurant.averageRate < 2.5 {
            rateSmallIcon.tintColor = .lightGray
        }
        
        rightBtn.isEnabled = false
        rightBtn.isHidden = false
        statusLbl.textColor = .mangoGreen
        
        switch order.status{
        case .UserOrdered, .RestaurantAccepted, .DriverAccepted, .DriverDeclined, .DriverStartedDelivery, .SentRequestDriver, .PickedUp:
            rightBtn.setupTitleForKey(key: "map")
            rightBtn.isEnabled = true
            rightBtn.backgroundColor = .mangoGreen
            
        case .RestaurantDeclined:
            rightBtn.setupTitleForKey(key: "renew")
            rightBtn.isEnabled = true
            statusLbl.textColor = .red

        case .Delivered:
            if order.rateable {
                rightBtn.setupTitleForKey(key: "rate")
                rightBtn.isEnabled = true
                rightBtn.backgroundColor = .mangoGreen
            }else{
                rightBtn.setupTitleForKey(key: "rate")
                rightBtn.isEnabled = false
                rightBtn.backgroundColor = .lightGray
            }

        case .Expired:
            rightBtn.setupTitleForKey(key: "renew")
            rightBtn.isEnabled = true
            statusLbl.textColor = .lightGray

        case .Cancelled:
            rightBtn.setupTitleForKey(key: "renew")
            rightBtn.isEnabled = true
            statusLbl.textColor = .red

        case .DriverArrived:
            rightBtn.setupTitleForKey(key: "confirm")
            rightBtn.isEnabled = false
            rightBtn.backgroundColor = .mangoGreen
        }
        
    }
    
    
}
