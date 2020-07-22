//
//  ReviewResturantTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/11/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class ReviewResturantTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!

    @IBOutlet weak var rateView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        avatarImageView.setHalfCornerRadius()
    }
    
    func populateWith(review: ReviewModel){
        avatarImageView.sd_setImage(with: URL(string: review.user.avatarUrl), placeholderImage: UIImage(named: "avatar_placeholder"), options: .refreshCached, completed: nil)
        nameLbl.text = review.user.firstName + " " + review.user.lastName
        messageLbl.text = review.commentBody
        dateLbl.text = review.date
        rateView.rating = review.rate
    }
}
