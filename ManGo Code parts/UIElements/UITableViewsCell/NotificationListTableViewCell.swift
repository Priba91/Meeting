//
//  NotificationListTableViewCell.swift
//  ManGO
//
//  Created by Priba on 9/3/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class NotificationListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var shadowView: ShadowMaterialView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.cornerRadius = 8
        backView.layer.cornerRadius = 8
    }

    func populate(notification: NotificationModel){
        titleLbl.text = notification.title
        timeLbl.text = notification.createdAt
        
        iconView.tintColor = .black
    }

}
