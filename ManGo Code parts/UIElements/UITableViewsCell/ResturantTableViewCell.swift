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

class ResturantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: MDCCard!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var popularLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var rateIcon: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var selectionBtn: UIButton!
    
    @IBOutlet weak var noDeliveryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        noDeliveryLbl.setupTitleForKey(key: "not_delivering_to_your_location")
        popularLbl.setupTitleForKey(key: "popular")
        popularLbl.backgroundColor = .mangoGreen
        popularLbl.setHalfCornerRadius()
        
        backView.layer.cornerRadius = 8
        shadowView.cornerRadius = 8
        shadowView.setShadowElevation(ShadowElevation.init(rawValue: 3), for: .normal)
    }

    func populate(resturant: ResturantModel){
        self.avatarImageView.sd_setImage(with: URL(string: resturant.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        
        let typeStr = NSMutableAttributedString(string: "$$$$ \(resturant.foodType)")
        
        var myRange = NSRange(location: 0, length: resturant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mangoGreen, range: myRange)
        
        myRange = NSRange(location: resturant.priceRange, length: 4 - resturant.priceRange)
        typeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray.withAlphaComponent(0.7), range: myRange)

        typeLbl.attributedText = typeStr
        
        nameLbl.text = resturant.name
        popularLbl.isHidden = !resturant.isPopular
        descLbl.text = resturant.description
        
        favoriteBtn.tintColor = resturant.isFavorite ? UIColor.favoriteRed : UIColor.separatorColor

        rateLbl.text = "\(resturant.averageRate) (\(resturant.numberOfRates))"
        timeLbl.text = "\(resturant.openTime) - \(resturant.closeTime)"
        
        if resturant.averageRate < 2.5 {
            rateIcon.tintColor = .lightGray
        }

        //TODO
        noDeliveryLbl.isHidden = true
    }


}

