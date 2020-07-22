//
//  MangoTextField.swift
//  ManGO
//
//  Created by Priba on 6/25/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import UIKit
import MaterialComponents

class MangoTextField: MDCTextField {

    var textFieldControllerFloating = MDCTextInputControllerFilled()

    override func awakeFromNib() {
        self.underline?.isHidden = true
        
        textFieldControllerFloating = MDCTextInputControllerFilled(textInput: self)
        textFieldControllerFloating.activeColor = .mangoGreen
        textFieldControllerFloating.floatingPlaceholderActiveColor = .mangoGreen
        textFieldControllerFloating.borderFillColor = .clear
        
        self.backgroundColor = .clear
        self.clearButtonMode = .never
        
        self.setLeftPaddingPoints(8)
        
    }
}
