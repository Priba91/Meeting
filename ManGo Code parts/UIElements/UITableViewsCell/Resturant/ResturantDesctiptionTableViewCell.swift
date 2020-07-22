//
//  ResturantDesctiptionTableViewCell.swift
//  ManGO
//
//  Created by Priba on 7/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class ResturantDesctiptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func populateWith(resturant: ResturantModel){
        descLbl.text = resturant.description
        
    }

}


//override func awakeFromNib() {
//    super.awakeFromNib()
//    self.selectionStyle = .none
//}
//
//func populateWith(resturant: ResturantModel){
//
//}
