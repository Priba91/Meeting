//
//  AddressSuggestionTableViewCell.swift
//  ManGO
//
//  Created by Priba on 6/24/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit

class AddressSuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func populate(suggestion: SuggestedAddress){
        
        streetLbl.text = suggestion.formattedAddress
        cityLbl.text = suggestion.county
        
    }

    func populateWithIcon(suggestion: SuggestedAddress){
        
        streetLbl.text = suggestion.formattedAddress
        cityLbl.text = suggestion.county
        
    }

}
