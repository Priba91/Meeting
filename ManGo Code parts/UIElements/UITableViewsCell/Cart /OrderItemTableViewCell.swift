//
//  OrderItemTableViewCell.swift
//  ManGO
//
//  Created by Priba on 8/12/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class OrderItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        checkImageView.tintColor = .lightGray
    }
    
    func populateWith(item: MenuItem){
        
        nameLbl.text = item.name

        self.productImage.sd_setImage(with: URL(string: item.imageUrl), placeholderImage: UIImage(named: "resturant_placeholder"), options: .refreshCached, completed: nil)
        priceLbl.text = item.getCountPriceString()
        
    }

}
