//
//  MenuSectionTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/11/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import SDWebImage

class MenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var cartCounter: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var popularLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        popularLbl.setHalfCornerRadius()
        popularLbl.setupTitleForKey(key: "popular")
        
        itemImageView.layer.cornerRadius = 10
    }
    
    func populateWith(item: MenuItem){
        
        nameLbl.text = item.name
        descLbl.text = item.shortDescription
        
        popularLbl.isHidden = !item.isPopular
        
        priceLbl.text = item.getPriceString()
        
        if item.imageUrl == ""{
            imageWidth.constant = 50
            itemImageView.image = nil
        }else{
            imageWidth.constant = 120
            itemImageView.contentMode = .scaleAspectFill
            itemImageView.sd_setImage(with: URL(string: item.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        }
    }
    
    func setCartCounter(count: Int){
        cartCounter.isHidden = count == 0 ? true : false
        cartCounter.text = "\(count)"
    }
}
