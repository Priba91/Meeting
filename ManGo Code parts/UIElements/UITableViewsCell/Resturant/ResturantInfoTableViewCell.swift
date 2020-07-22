//
//  ResturantInfoTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class ResturantInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodTypeLbl: UILabel!
    @IBOutlet weak var foodTypeValueLbl: UILabel!
    
    @IBOutlet weak var moodIcon: UIImageView!
    @IBOutlet weak var moodLbl: UILabel!
    @IBOutlet weak var moodMoreBtn: UIButton!
    
    @IBOutlet weak var addressIcon: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var openingIcon: UIImageView!
    @IBOutlet weak var openingLbl: UILabel!
    @IBOutlet weak var openingMoreBtn: UIButton!
    
    @IBOutlet weak var paymentIcon: UIImageView!
    @IBOutlet weak var minPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        foodTypeLbl.setupTitleForKey(key: "food_type")
        moodMoreBtn.setupTitleForKey(key: "more_info")
        openingMoreBtn.setupTitleForKey(key: "more_info")
    }
    
    func populateWith(resturant: ResturantModel){
        
        moodIcon.tintColor = .black
        addressIcon.tintColor = .black
        openingIcon.tintColor = .black
        paymentIcon.tintColor = .black
        
        foodTypeValueLbl.text = resturant.foodType
        moodLbl.text = Utils.getMoodFromRate(rate: resturant.averageRate)
        addressLbl.text = resturant.address.street + " " + resturant.address.streetNumber
        openingLbl.text = resturant.openTime + " - " + resturant.closeTime

        minPriceLbl.text = "\(LanguageManager.sharedInstance.getStringForKey(key: "minimum")) \(resturant.minDeliveryPrice) \(DataManager.sharedInstance.currency)"
    }
}
