//
//  MaterialComponentsExtensions.swift
//  ManGO
//
//  Created by Priba on 6/21/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import MaterialComponents

extension MDCButton {
    
    func setBottomWhiteStyle(){
        
        self.titleLabel?.textColor = .mangoGreen
        self.setBackgroundColor(.white, for: .normal)
        self.setShadowColor(.black, for: .normal)
        
    }
    
}

extension MDCCard {
    
    func setupInitState(){
        self.setShadowElevation(ShadowElevation.init(rawValue: 3), for: .normal)
    }
    
    func setupWithCornerRadius(){
        setupInitState()
        self.cornerRadius = 8
    }
}

extension MDCTextField {
    
    func setupInitState(placeholderKey: String, returnKeyType: UIReturnKeyType)-> MDCTextInputControllerFilled{

        self.placeholder = LanguageManager.sharedInstance.getStringForKey(key: placeholderKey)
        self.underline?.isHidden = true
        self.returnKeyType = returnKeyType
        self.backgroundColor = .clear

        let floating = MDCTextInputControllerFilled(textInput: self)
        
        floating.activeColor = .mangoGreen
        floating.floatingPlaceholderActiveColor = .mangoGreen
        floating.borderFillColor = .clear

        return floating
    }
    
    func setupInitUnderlineState( returnKeyType: UIReturnKeyType, tintColor: UIColor = .mangoGreen)-> MDCTextInputControllerUnderline{
        
        //self.placeholder = LanguageManager.sharedInstance.getStringForKey(key: placeholderKey)
        self.underline?.isHidden = false
        self.returnKeyType = returnKeyType
        self.backgroundColor = .clear
        self.clearButtonMode = .never
        let floating = MDCTextInputControllerUnderline(textInput: self)
        
        floating.underlineViewMode = .always
        floating.activeColor = tintColor
        floating.normalColor = tintColor
        floating.floatingPlaceholderActiveColor = tintColor
        floating.borderFillColor = .clear
        
        return floating
    }
}
