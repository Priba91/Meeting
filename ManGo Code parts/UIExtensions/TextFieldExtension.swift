//
//  TextFieldExtension.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setupForLayout(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
        
        self.textColor = UIColor.white
        
        self.setLeftPaddingPoints(8)
        self.setRightPaddingPoints(8)
    }
    
    func setupForDarkLayout(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separatorColor.cgColor
        self.layer.cornerRadius = 8
        
        self.textColor = UIColor.darkGray
        
        self.setLeftPaddingPoints(24)
        self.setRightPaddingPoints(24)
    }
    
    func setPlaceholderForKey(key:String, textColor:UIColor = UIColor.white) {
        self.attributedPlaceholder = NSAttributedString(string: LanguageManager.sharedInstance.getStringForKey(key: key),
                                                               attributes: [NSAttributedString.Key.foregroundColor: textColor])
    }
    
    func setTextForKey(key:String) {
        self.text = LanguageManager.sharedInstance.getStringForKey(key: key)
    }
    
    func cleanSpacesAndNewLines(){
        var trimmedString = self.text!.trimmingCharacters(in:
            NSCharacterSet.whitespacesAndNewlines
        )
        self.text = trimmedString
    }
}
