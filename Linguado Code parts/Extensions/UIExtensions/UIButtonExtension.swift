//
//  UIButtonExtension.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func setupTitleForKey(key:String, uppercased:Bool = false) {
        self.setTitle(LanguageManager.sharedInstance.getStringForKey(key: key, uppercased: uppercased), for: .normal)
        
        setAppFont()
    }
    
    func setupForLayoutTypeBlack() {
        self.layer.cornerRadius = 8
        
        self.backgroundColor = UIColor.black
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
    }
    
    func setupForLayoutTypeUnfiled() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.setHalfCornerRadius()
        
        self.backgroundColor = UIColor.clear
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    
    func setAppFont() {
        self.substituteFontName = "Roboto"
    }
    
    public var substituteFontName : String {
        get {
            return self.titleLabel?.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.titleLabel?.font?.fontName.lowercased() ?? "";
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
            self.titleLabel?.font = UIFont(name: fontName, size: self.titleLabel?.font.pointSize ?? 17)
        }
    }

}
