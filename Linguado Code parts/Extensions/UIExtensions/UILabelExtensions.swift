//
//  UILabelExtensions.swift
//  JobDeal
//
//  Created by Priba on 12/9/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setupTitleForKey(key:String, uppercased:Bool = false) {
        self.text = LanguageManager.sharedInstance.getStringForKey(key: key, uppercased: uppercased)
        
        setAppFont()
    }
    
    func setLabelHalfCornerRadius() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
    
    func setAppFont() {
        self.substituteFontName = "Roboto"
    }
    
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            } else if fontNameToTest.range(of: "regular") != nil {
                fontName += "-Regular"
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
}
