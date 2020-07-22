//
//  TextViewExtension.swift
//  JobDeal
//
//  Created by Priba on 1/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setAppFont()
    }
    
    func setupForDarkLayout(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separatorColor.cgColor
        self.layer.cornerRadius = 8
                
        self.contentInset = UIEdgeInsets(top: 8,left: 24,bottom: 8,right: 24)
    }
    
    func setAppFont(){
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
