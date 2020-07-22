//
//  MenuItemInfoTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/19/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class MenuItemInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cartCounter: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var popularLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        popularLbl.setHalfCornerRadius()
        popularLbl.setupTitleForKey(key: "popular")
        
    }
    
    func populateWith(item: MenuItem){
        
        nameLbl.text = item.name
        descLbl.text = item.shortDescription
        
        popularLbl.isHidden = !item.isPopular
        
        priceLbl.text = item.getPriceString()
        
    }
    
    
    func setCartCounter(count: Int){
        cartCounter.isHidden = count == 0 ? true : false
        cartCounter.text = "\(count)"
    }

}
